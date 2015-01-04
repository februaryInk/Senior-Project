class FriendshipsController < ApplicationController
    def create
        @user = User.find_by( params[ :friendship ][ :friend_id ] )
        @friendship = current_user.friendships.new( friendship_params )
        @reciprocated_friendship = current_user.reciprocated_friendships.new( reciprocated_friendship_params )
        begin
            @friendship.transaction do
                @friendship.save
                @reciprocated_friendship.save
            end
            redirect_to :back, :flash => { :success => "An offer of friendship has been sent to #{ @user.username }." }
        rescue Exception
            redirect_to :back, :flash => { :friendship_errors => @friendship.errors.full_messages }
        end
    end
    
    def destroy
        friendship = Friendship.find( params[ :id ] )
        reciprocated_friendship = current_user.reciprocated_friendships.find_by( :user_id => friendship.friend_id )
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
    
    def update
        friendship = Friendship.find( params[ :id ] )
        reciprocated_friendship = current_user.reciprocated_friendships.find_by( :user_id => friendship.friend_id )
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