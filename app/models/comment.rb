class Comment < ActiveRecord::Base
    
    # make the default order of collections of comments dependent on the
    # time they were created_at, most recent last.
    default_scope -> { order( :created_at => :asc ) }
    
    # VALIDATIONS
    
    # conversation is used rather than conversation_id because it must be possible
    # for a conversation and a comment to be created at the same time.
    validates :user_id, { :presence => true }
    validates :conversation, { :presence => true }
    validates :content, { :presence => true }
    
    # ASSOCIATIONS

    belongs_to :user
    belongs_to :conversation
end
