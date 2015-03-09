class SectionsController < ApplicationController
    
    def create
        # make a new section with counts initialized to zero at the end of the stack.
        @manuscript = Manuscript.find( params[ :manuscript_id ] )
        position = @manuscript.sections.count + 1
        name = "Chapter #{ position }"
        @section = @manuscript.sections.build( :user_id => current_user.id, :name => name, :position => position, :word_count => 0, :dark_word_count => 0, :light_word_count => 0, :might_word_count => 0 )
        @section.save
    end
    
    def destroy
        # destroy the section and update the manuscript counts.
        @section = Section.find( params[ :id ] )
        @manuscript = @section.manuscript
        destroyed_position = @section.position
        @section.destroy
        @sections = @manuscript.sections.all
        @sections.each do | section |
            if section.position > destroyed_position
                section.update_attributes( :position => section.position - 1 )
            end
        end
    end
    
    def rename
        @section = Section.find( params[ :section_id ] )
        @section.update_attributes( :name => params[ :name ] )
        render :nothing => true
    end
    
    def select
        @open_section = Section.find( params[ :data_value ] )
    end
    
    def sort
        positions = JSON.parse( params[ :data_value ] )
        i = 1
        for id in positions
            section = Section.find( id.to_i )
            section.update_attributes( :position => i )
            i += 1
        end
        @manuscript = Section.find( positions[ 1 ].to_i ).manuscript
        @sections = @manuscript.sections.all
    end
    
    def update
        # save the section changes, then count key words and update the section and manuscript counts.
        @section = Section.find( params[ :id ] )
        @manuscript = @section.manuscript
        @inkling = @manuscript.inkling
        might_word_count = 0
        light_word_count = 0
        dark_word_count = 0
        content = params[ :section ][ :content ]
        downcased_content = content.downcase
        word_count = downcased_content.scan(/[\w-]+/).size
        might_words.each do | word |
            might_word_count += downcased_content.scan( word ).size
        end
        light_words.each do | word |
            light_word_count += downcased_content.scan( word ).size
        end
        dark_words.each do | word |
            dark_word_count += downcased_content.scan( word ).size
        end
        @section.update_attributes( :might_word_count => might_word_count, :content => content, :light_word_count => light_word_count, :dark_word_count => dark_word_count, :word_count => word_count )
        update_manuscript_counts( @manuscript )
        update_inkling_points( @manuscript, @inkling )
        update_inkling_parts( @inkling )
        render :nothing => true
    end
    
    private
    
        def might_words
            %w[ arrow compass east north plains river sea snow south sword tree west wild wilderness ]
        end
        
        def light_words
            %w[ beautiful blush breath candle eyes gown handsome light lips love necklace ruffles sweet ]
        end
    
        def dark_words
            %w[ black blood dark destroy fear fright gore lightening maimed spider storm sweat thunder wolf ]
        end

        def section_params
            params.require( :section ).permit( :manuscript_id, :name )
        end
        
        def update_inkling_parts( inkling )
            all_parts = inkling.inkling_parts
            might = 0
            light = 0
            dark = 0
            all_parts.each do | part |
                might += part.might_points
                light += part.light_points
                dark += part.dark_points
            end
            point_changes = { :might_points => ( inkling.might_points - might ), :light_points => ( inkling.light_points - light ), :dark_points => ( inkling.dark_points - dark ) }
            point_changes.each do | qualifier, point_change |
                while point_change < 0
                    offset = rand( all_parts.count )
                    part = all_parts.offset( offset ).first
                    if eval( 'part.' << qualifier.to_s ) > 0
                        part.update_attributes( qualifier => eval( 'part.' << qualifier.to_s ) - 1 )
                        point_change += 1
                        unless eval( 'part.' << qualifier.to_s ) > 0
                            all_parts.reject { | p | p == part }
                        end
                        total = part.might_points + part.light_points + part.dark_points
                        new_selector = part.kind + '-' + part.might_points.to_s + part.light_points.to_s + part.dark_points.to_s
                        part.update_attributes( :selector => new_selector, :total_points => total )
                    end
                end
            end
            point_changes.each do | qualifier, point_change |
                all_parts = inkling.inkling_parts
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
        
        def update_inkling_points( manuscript, inkling )
            # calculate the total inkling points with a cap of 21 points.
            # calculate the qualifier word points with two-point precision.
            # as long as these qualifier word points are not all whole numbers, 
            point_word_count = manuscript.might_word_count + manuscript.light_word_count + manuscript.dark_word_count # 3
            points = ( ( point_word_count * 50 ) / manuscript.word_count.to_f ).to_i # 1
            if ( points > 21 ) then points = 21 end
            might_points = ( ( manuscript.might_word_count / point_word_count.to_f ) * points ).floor # 0
            light_points = ( ( manuscript.light_word_count / point_word_count.to_f ) * points ).floor # 0
            dark_points = ( ( manuscript.dark_word_count / point_word_count.to_f ) * points ).floor # 0
            might_modulus = ( manuscript.might_word_count ) % point_word_count # 1
            light_modulus = ( manuscript.light_word_count ) % point_word_count # 2
            dark_modulus = ( manuscript.dark_word_count ) % point_word_count # 0
            if ( might_modulus or light_modulus or dark_modulus )
                point_hash = { :might => might_points, :light => light_points, :dark => dark_points }
                modulus_hash = { :might => might_modulus, :light => light_modulus, :dark => dark_modulus }
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
                    point_hash[ maximum_qualifier.sample ] += 1
                else
                    point_hash[ max_partials.keys.first ] += 1
                end
            end
            inkling.update_attributes( :might_points => point_hash[ :might ], :light_points => point_hash[ :light ], :dark_points => point_hash[ :dark ], :points => ( point_hash[ :might ] + point_hash[ :light ] + point_hash[ :dark ] ) )
        end
        
        def update_manuscript_counts( manuscript )
            might_word_count = 0
            light_word_count = 0
            dark_word_count = 0
            word_count = 0
            manuscript.sections.each do | section |
                might_word_count += section.might_word_count
                light_word_count += section.light_word_count
                dark_word_count += section.dark_word_count
                word_count += section.word_count
            end
            manuscript.update_attributes( :might_word_count => might_word_count, :light_word_count => light_word_count, :dark_word_count => dark_word_count, :word_count => word_count )
        end
end
