class Friendship < ActiveRecord::Base

    belongs_to :user
    belongs_to :accepted_friend, :class_name => 'User', :foreign_key => 'friend_id'
    belongs_to :friend, :class_name => 'User'
    belongs_to :pending_friend, :class_name => 'User', :foreign_key => 'friend_id'
    belongs_to :waiting_friend, :class_name => 'User', :foreign_key => 'friend_id'
    
    validates :friend_id, :presence => true
    validates :status, :inclusion => { :in => [ 'accepted', 'pending', 'waiting' ] }, :presence => true
    validates :user_id, :presence => true
    
    # instance methods
    
    def reciprocal
        reciprocal_user_id = self.friend_id
        reciprocal_friend_id = self.user_id
        
        reciprocated_friendship = Friendship.find_by( :user_id => reciprocal_user_id, :friend_id => reciprocal_friend_id )
    end
end
