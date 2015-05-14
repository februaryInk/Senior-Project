class Manuscript < ActiveRecord::Base

    # RELATIONSHIPS

    belongs_to :user
    
    has_one :inkling, :inverse_of => :manuscript, :dependent => :destroy
    
    has_many :sections, :dependent => :destroy
    has_many :feedback
    
    # VALIDATIONS
    
    validates :title, :presence => true, :length => { :maximum => 250 }
    validates :genre, :presence => true, :inclusion => { :in => %w( adventure action fantasy historical horror mystery romance paranormal western ) }, :reduce => true
    validates :user_id, :presence => true, :numericality => { :only_integer => true }, :reduce => true
    
    accepts_nested_attributes_for :inkling
    
    # INSTANCE METHODS
    
    # generate a new inkling object with all the default parts. this is to be used
    # when a manuscript is created, so that every manuscript has an inkling 
    # counterpart.
    def generate_inkling
        inkling = self.inkling
        guides = InklingPartGuide.all
        
        # use the inkling_part_guides to generate all of the necessary parts. 
        # however, this may be hard on the database, given that each inkling
        # creates 20+ child part records. can't this be reduced to a single
        # record, with a column for each part rather than a record for each part?
        guides.each do | guide |
            selector = guide.kind + '-000'
            inkling.inkling_parts.create( :inkling_part_guide_id => guide.id, :kind => guide.kind, :total_points => 0, :might_points => 0, :light_points => 0, :dark_points => 0, :selector => selector )
        end
    end
    
    # update the word and keyword counts for the manuscript. this should be used when
    # a section is saved.
    def update_counts
        might_word_count = 0
        light_word_count = 0
        dark_word_count = 0
        word_count = 0
        
        self.sections.each do | section |
            might_word_count += section.might_word_count
            light_word_count += section.light_word_count
            dark_word_count += section.dark_word_count
            word_count += section.word_count
        end
        
        self.update_attributes( :might_word_count => might_word_count, :light_word_count => light_word_count, :dark_word_count => dark_word_count, :word_count => word_count )
    end
end
