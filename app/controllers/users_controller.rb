class UsersController < ApplicationController
    layout 'default.html'
    include AuthorizationFilters
    
    before_action :admin_user, :only => [ :destroy, :index ]
    before_action :correct_user, :only => [ :destroy, :edit, :manuscripts, :social, :update ]
    before_action :signed_in_user, :only => [ :destroy, :edit, :index, :manuscripts, :social, :update ]
    
    def create
        @user = User.new( user_params )
        respond_to do | format |
            if @user.save
                @saved = true
                @user.send_activation_email
                flash[ :info ] = 'Activation email has been sent. Please check your inbox.'
                format.html { redirect_to root_path }
            else
                @saved = false
            end
            format.js { render layout: false, content_type: 'text/javascript' }
        end
    end
    
    def destroy
        User.find( params[ :id ] ).destroy
        redirect_to users_url
    end
    
    def edit
        @account_tab = true
        @user = User.find( params[ :id ] )
    end

    def index
        @letter = params[ :letter ] || 'a'
        @users = User.where( "username LIKE :first", :first => "#{ @letter }%" ).order( 'username ASC' ).paginate( :page => params[ :page ] )
    end
    
    def manuscripts
        @account_tab = true
        @manuscripts = current_user.manuscripts
    end

    def new
        @user = User.new
    end

    def show
        @account_tab = true
        @post = Post.new
        @user = User.find( params[ :id ] )
        @activity_feed = @user.activity_feed.paginate( :page => params[ :page ] )
        unless current_user.nil?
            unless current_user.friends.include?( @user )
                @friendship = current_user.friendships.new
                @reciprocated_friendship = current_user.reciprocated_friendships.new
            else
                @friendship = current_user.friendships.find_by( :friend_id => @user.id )
                @reciprocated_friendship = @user.friendships.find_by( :friend_id => current_user.id )
            end
        end
    end
    
    def social
        @account_tab = true
        @accepted_friends = current_user.accepted_friends.order( 'username ASC' ).paginate( :page => params[ :friend_page ] )
        @comments = current_user.comments.order( 'created_at DESC' ).paginate( :page => params[ :comment_page ], :per_page => 10 )
        @conversations = current_user.conversations.order( 'created_at DESC' ).paginate( :page => params[ :conversation_page ], :per_page => 5 )
        @pending_friends = current_user.pending_friends.order( 'username ASC' ).paginate( :page => params[ :p_friend_page ] )
        @waiting_friends = current_user.waiting_friends.order( 'username ASC' ).paginate( :page => params[ :w_friend_page ] )
    end
    
    def update
        @user = User.find( params[ :id ] )
        if ( @user.authenticate( params[ :authentication ][ :password ] ) && @user.update_attributes( user_params ) )
            flash[ :success ] = 'Account settings were successfully edited.'
            redirect_to edit_user_path( @user.id )
        else
            render :edit
        end
    end
    
    private
    
        def correct_user
            @user = User.find( params[ :id ] )
            redirect_to( root_url ) unless current_user?( @user )
        end
    
        def user_params
            params.require( :user ).permit( :biography, :email, :password, :password_confirmation, :username )
        end
end
