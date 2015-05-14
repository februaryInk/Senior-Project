class Comment < ActiveRecord::Base

    # RELATIONSHIPS

    belongs_to :user
    belongs_to :conversation
    
    # make the default order of collections of comments dependent on the
    # time they were created_at, most recent last.
    default_scope -> { order( :created_at => :asc ) }
    
    # VALIDATIONS
    
    validates :user_id, { :presence => true }
    validates :content, { :presence => true }
    validates :conversation, { :presence => true }
end
