class GenreManuscript < ActiveRecord::Base
    
    # ASSOCIATIONS
    
    belongs_to :genre
    belongs_to :manuscript
end
