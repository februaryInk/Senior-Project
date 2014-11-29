class Conversation < ActiveRecord::Base
    belongs_to :forum
    belongs_to :user
    
    has_many :comments, :dependent => :destroy
    
    validates :forum_id, { :presence => true }
    validates :user_id, { :presence => true }
    validates :name, { :length => { :maximum => 140 }, :presence => true }
end
