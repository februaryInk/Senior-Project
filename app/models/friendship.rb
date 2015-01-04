class Friendship < ActiveRecord::Base
    belongs_to :user
    belongs_to :accepted_friend, :class_name => 'User', :foreign_key => 'friend_id'
    belongs_to :friend, :class_name => 'User'
    belongs_to :pending_friend, :class_name => 'User', :foreign_key => 'friend_id'
    belongs_to :waiting_friend, :class_name => 'User', :foreign_key => 'friend_id'
    
    # accepts_nested_attributes_for :friendships
    
    validates :friend_id, :presence => true
    validates :status, :inclusion => { :in => [ 'accepted', 'pending', 'waiting' ] }, :presence => true
    validates :user_id, :presence => true
    
    def Friendship.accept( user, friend )
        # transactions are SQL statements that are permanent only if all
        # statements in the block succeed.
        transaction do
            self.accept_one_side( user, friend )
            self.accept_one_side( friend, user )
        end
    end
    
    def Friendship.accept_one_side( user, friend )
        request = user.friendships.find_by( :friend_id => friend.id )
        request.status = 'accepted'
        request.save!
    end
end
