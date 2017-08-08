class Rating < ApplicationRecord
    
    include CallableByName
    
    # ASSOCIATIONS
    
    has_many :manuscripts
end
