# friendship records are intended to come in pairs so that they are always 
# "even": essentially, the user_id and friend_id columns are just reversed 
# between the records. this makes it easier to find all friendships for either 
# user.

class Friendship < ActiveRecord::Base
    
    # VALIDATIONS
    
    validates :friend_id, :presence => true
    validates :user_id, :presence => true
    
    # RELATIONSHIPS

    belongs_to :user
    belongs_to :status, :class_name => 'FriendshipStatus', :foreign_key => 'friendship_status_id'
    
    belongs_to :accepted_friend, :class_name => 'User', :foreign_key => 'friend_id'
    belongs_to :friend, :class_name => 'User'
    belongs_to :pending_friend, :class_name => 'User', :foreign_key => 'friend_id'
    belongs_to :waiting_friend, :class_name => 'User', :foreign_key => 'friend_id'
    
    # INSTANCE METHODS
    
    # retrieve the reciprocal of a friendship (that is, the other friendship in the 
    # pair.
    def reciprocal
        reciprocal_user_id = self.friend_id
        reciprocal_friend_id = self.user_id
        
        reciprocated_friendship = Friendship.find_by( :user_id => reciprocal_user_id, :friend_id => reciprocal_friend_id )
    end
end
