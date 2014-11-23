class ForumPost < ActiveRecord::Base
    belongs_to :user
    belongs_to :forum_thread
    
    validates :user_id, { :presence => true }
    validates :content, { :presence => true }
    validates :forum_thread_id, { :presence => true }
end
