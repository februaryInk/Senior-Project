class WordCount < ApplicationRecord
    
    # ASSOCIATIONS
    
    belongs_to :manuscript
    belongs_to :user
end
