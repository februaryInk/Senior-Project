class FriendshipsController < ApplicationController

    include AuthorizationFilters
    
    # BEFORE ACTIONS
    
    before_action :signed_in_user

    # create a pair of friendship objects, one for the pending friend and one for
    # the waiting friend. the friendship must be accepted before being active.
    def create
        new_friend = User.find( params[ :friendship ][ :friend_id ] )
        friendship = current_user.friendships.new( friendship_params )
        reciprocated_friendship = friendship.reciprocal
        begin
            # if any part of the transaction fails, the entire thing is rolled back.
            # friendships and reciprocated friendships always have to be changed
            # together, so we want to prevent any possibility of only one side
            # being affected.
            friendship.transaction do
                friendship.save
                reciprocated_friendship.save
            end
            redirect_to :back, :flash => { :success => "An offer of friendship has been sent to #{ new_friend.username }." }
        rescue Exception
            redirect_to :back, :flash => { :friendship_errors => friendship.errors.full_messages }
        end
    end
    
    # destroy the friendship and its reciprocal.
    def destroy
        friendship = Friendship.find( params[ :id ] )
        reciprocated_friendship = friendship.reciprocal
        begin
            friendship.transaction do
                friendship.destroy
                reciprocated_friendship.destroy
            end
            redirect_to :back
        rescue Exception
            redirect_to :back, :flash => { :friendship_errors => friendship.errors.full_messages }
        end
    end
    
    # set a friendship's status to accepted for both users.
    def update
        friendship = Friendship.find( params[ :id ] )
        reciprocated_friendship = friendship.reciprocal
        begin
            friendship.transaction do
                friendship.update_attributes( :status => 'accepted' )
                reciprocated_friendship.update_attributes( :status => 'accepted' )
            end
            redirect_to :back, :flash => { :success => "You are now friends with #{ @user.username }." }
        rescue Exception
            redirect_to :back, :flash => { :friendship_errors => friendship.errors.full_messages }
        end
    end
    
    private
    
        def friendship_params
            params.require( :friendship ).permit( :friend_id, :status, :user_id )
        end
        
        def reciprocated_friendship_params
            params.require( :reciprocated_friendship ).permit( :friend_id, :status, :user_id )
        end
end