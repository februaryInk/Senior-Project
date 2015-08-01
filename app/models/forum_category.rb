class ForumCategory < ActiveRecord::Base

    include CalledClassMethod

    # RELATIONSHIPS
    
    has_many :forums
end
