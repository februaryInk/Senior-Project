class ForumCategory < ActiveRecord::Base

    include CallableByName

    # ASSOCIATIONS
    
    has_many :forums
end
