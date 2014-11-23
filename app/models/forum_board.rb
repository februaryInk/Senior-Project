class ForumBoard < ActiveRecord::Base
    has_many :forum_threads
end
