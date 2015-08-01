class Inkling < ActiveRecord::Base

    # CLASS CONSTANTS
    
    CURRENCIES = [ 'Points', 'Words' ]
    
    # VALIDATIONS
    
    validates :word_count_goal, :presence => true, :numericality => { :only_integer => true }, :reduce => true
    validates :word_rate_goal, :presence => true, :numericality => { :only_integer => true }, :reduce => true
    validates :word_rate_goal_basis, :presence => true, :numericality => { :only_integer => true }, :reduce => true
    validates :revival_fee, :presence => true, :numericality => { :only_integer => true }, :reduce => true
    validates :revival_fee_currency, :presence => true, :inclusion => { :in => CURRENCIES }, :reduce => true
    
    # RELATIONSHIPS

    belongs_to :manuscript
    
    has_many :inkling_parts
    
    has_one :user, :through => :manuscript
    
    # INSTANCE METHODS
    
    # transform the inkling based on the number of words and keyword counts in the
    # manuscript.
    def update_parts
        all_parts = self.inkling_parts
        might = 0
        light = 0
        dark = 0
        
        # calculate the number of points currently invested in the inkling's 
        # various parts.
        all_parts.each do | part |
            might += part.might_points
            light += part.light_points
            dark += part.dark_points
        end
        
        # figure the difference between the number of points that should be invested 
        # and the number that is invested for each category.
        point_changes = { :might_points => ( self.might_points - might ), :light_points => ( self.light_points - light ), :dark_points => ( self.dark_points - dark ) }
        
        # remove points first, if any need to be removed.
        point_changes.each do | qualifier, point_change |
            while point_change < 0
                # choose a random part from the collection of all parts.
                offset = rand( all_parts.count )
                part = all_parts.offset( offset ).first
                
                if eval( 'part.' << qualifier.to_s ) > 0
                    part.update_attributes( qualifier => eval( 'part.' << qualifier.to_s ) - 1 )
                    point_change += 1
                    unless eval( 'part.' << qualifier.to_s ) > 0
                        # avoid trying the same part twice by removing it from the collection 
                        # if it doesn't work.
                        all_parts.reject { | p | p == part }
                    end
                    
                    # if it did work, update the part.
                    total = part.might_points + part.light_points + part.dark_points
                    new_selector = part.kind + '-' + part.might_points.to_s + part.light_points.to_s + part.dark_points.to_s
                    part.update_attributes( :selector => new_selector, :total_points => total )
                end
            end
        end
        
        # then add points, if any need to be added.
        point_changes.each do | qualifier, point_change |
            all_parts = self.inkling_parts
            while point_change > 0
                offset = rand( all_parts.count )
                part = all_parts.offset( offset ).first
                
                if eval( 'part.' << qualifier.to_s ) < eval( 'part.inkling_part_guide.max_' << qualifier.to_s ) and ( part.total_points < part.inkling_part_guide.max_points )
                    part.update_attributes( qualifier => eval( 'part.' << qualifier.to_s ) + 1 )
                    point_change -= 1
                    unless ( eval( 'part.' << qualifier.to_s ) < eval( 'part.inkling_part_guide.max_' << qualifier.to_s ) ) and ( part.total_points < part.inkling_part_guide.max_points )
                        all_parts.reject { | p | p == part }
                    end
                    
                    total = part.might_points + part.light_points + part.dark_points
                    new_selector = part.kind + '-' + part.might_points.to_s + part.light_points.to_s + part.dark_points.to_s
                    part.update_attributes( :selector => new_selector, :total_points => total )
                end
            end
        end
    end
    
    # calculate the number of points that should be put in each word category.
    def update_points( manuscript )
        # calculate the number of qualifier words and the total inkling points 
        # with a cap of 21 points.
        qualifier_word_count = manuscript.might_word_count + manuscript.light_word_count + manuscript.dark_word_count
        
        # ...although, if there are no qualifier words in the manuscript, there
        # is no need to calculate points. just update and return.
        if ( qualifier_word_count < 1 )
            self.update_attributes( :might_points => 0, :light_points => 0, :dark_points => 0, :points => 0 )
            return
        end
        
        points = ( ( qualifier_word_count * 500 ) / manuscript.word_count.to_f ).ceil
        if ( points > 21 ) then points = 21 end
        
        # calculate the number out of the total points that belong to each 
        # category.
        might_points = ( ( manuscript.might_word_count * points ) / qualifier_word_count.to_f ).floor
        light_points = ( ( manuscript.light_word_count * points ) / qualifier_word_count.to_f ).floor
        dark_points = ( ( manuscript.dark_word_count * points ) / qualifier_word_count.to_f ).floor
        
        # put the calculated values in hashes for easy access and iteration.
        point_hash = { :might => might_points, :light => light_points, :dark => dark_points }
        
        unassigned_points = points - ( might_points + light_points + dark_points )
        
        # calculate the modulus...
        might_modulus = ( manuscript.might_word_count * points ) % qualifier_word_count
        light_modulus = ( manuscript.light_word_count * points ) % qualifier_word_count
        dark_modulus = ( manuscript.dark_word_count * points ) % qualifier_word_count
        
        # put the modulus values in hashes for easy access and iteration.
        modulus_hash = { :might => might_modulus, :light => light_modulus, :dark => dark_modulus }
        
        # ...so that if the divisions are not entirely even, we can determine where 
        # to put the leftover point(s).
        while unassigned_points > 0
            
            # find the maximum value in the modulus hash. construct a new hash that
            # contains only the key(s)/value(s) for which the value is the maximum.
            max_modulus = modulus_hash.values.max
            max_partials = Hash[ modulus_hash.select { | key, value | value == max_modulus } ]
            
            if max_partials.length > 1
                maximum = 0
                maximum_qualifier = []
                max_partials.each do | qualifier, modulus |
                
                    if point_hash[ qualifier ] > maximum
                        maximum = point_hash[ qualifier ]
                        maximum_qualifier = [ qualifier ]
                        
                    elsif point_hash[ qualifier ] == maximum
                        maximum_qualifier.push( qualifier )
                    end
                end
                key = maximum_qualifier.sample
                point_hash[ key ] += 1
                modulus_hash[ key ] = 0
            else
                point_hash[ max_partials.keys.first ] += 1
                modulus_hash[ max_partials.keys.first ] = 0
            end
            unassigned_points -= 1
        end
        self.update_attributes( :might_points => point_hash[ :might ], :light_points => point_hash[ :light ], :dark_points => point_hash[ :dark ], :points => points )
    end
end
