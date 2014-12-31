class Comment < ActiveRecord::Base
    belongs_to :user
    belongs_to :conversation
    
    default_scope -> { order( :created_at => :asc ) }
    
    validates :user_id, { :presence => true }
    validates :content, { :presence => true }
    validates :conversation, { :presence => true }
end
