class GenreManuscript < ActiveRecord::Base
    
    # RELATIONSHIPS
    
    belongs_to :genre
    belongs_to :manuscript
end
