class Manuscript < ActiveRecord::Base
    
    # VALIDATIONS
    
    validates :title, :presence => true, :length => { :maximum => 250 }
    validates :genres, :presence => true, :reduce => true
    validates :rating_id, :presence => true, :numericality => { :only_integer => true }, :reduce => true
    validates :user_id, :presence => true, :numericality => { :only_integer => true }, :reduce => true
    
    # ASSOCIATIONS

    belongs_to :rating
    belongs_to :user
    
    has_one :inkling, :inverse_of => :manuscript, :dependent => :destroy
    
    has_many :word_counts, :dependent => :destroy
    has_many :feedback
    has_many :sections, :dependent => :destroy
    
    has_many :genre_manuscripts
    has_many :genres, :through => :genre_manuscripts
    
    accepts_nested_attributes_for :genre_manuscripts
    accepts_nested_attributes_for :inkling
    
    # INSTANCE METHODS
    
    # update the word and keyword counts for the manuscript. this should be used when
    # a section is saved.
    def update_counts
        word_count = 0
        
        self.sections.each do | section |
            word_count += section.word_count
        end
        
        self.update_attributes( :word_count => word_count )
    end
end
