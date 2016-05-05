class Rating < ActiveRecord::Base
    
    include CallableByName
    
    # ASSOCIATIONS
    
    has_many :manuscripts
end
