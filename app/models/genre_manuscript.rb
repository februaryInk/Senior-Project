class GenreManuscript < ApplicationRecord
    
    # ASSOCIATIONS
    
    belongs_to :genre
    belongs_to :manuscript
end
