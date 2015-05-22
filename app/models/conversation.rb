class Conversation < ActiveRecord::Base
    
    # VALIDATIONS
    
    validates :forum_id, { :presence => true }
    validates :user_id, { :presence => true }
    validates :name, { :length => { :maximum => 140 }, :presence => true }
    
    # RELATIONSHIPS

    belongs_to :forum
    belongs_to :user
    
    # inverse_of sends a back reference to child objects with conversation
    # parents. this allows the first comment child to be created at the
    # same time as its conversation parent, while also allowing the child to
    # confirm that the parent exists (since it can't validate parent id, if 
    # they are made at the same time).
    has_many :comments, :inverse_of => :conversation, :dependent => :destroy
    
    accepts_nested_attributes_for :comments
end
