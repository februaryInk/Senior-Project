class ForumCategory < ApplicationRecord

    include CallableByName

    # ASSOCIATIONS
    
    has_many :forums
end
