class UsersController < ApplicationController
    layout 'default.html'
    
    before_action :correct_user, :only => [ :edit, :update ]
    before_action :signed_in_user, :only => [ :edit, :update ]
    
    def create
        @user = User.new( user_params )
        if @user.save
            signin @user
            redirect_to user_url( @user )
        else
            render new
        end
    end
    
    def edit
        @user = User.find( params[ :id ] )
    end

    def index
        @letter = params[ :letter ] || 'a'
        @users = User.where( "username LIKE :first", :first => "#{ @letter }%" ).order( 'username ASC' ).paginate( :page => params[ :page ] )
    end

    def new
        @user = User.new
    end

    def show
        @account_tab = true
        @user = User.find( params[ :id ] )
    end
    
    def update
        @user = User.find( params[ :id ] )
        if @user.update_attributes( user_params )
            redirect_to user_url( @user )
        else
            render 'edit'
        end
    end
    
    private
    
        def correct_user
            @user = User.find( params[ :id ] )
            redirect_to( root_url ) unless current_user?( @user )
        end
    
        def signed_in_user
            unless signed_in?
                store_location
                redirect_to signin_url
            end
        end
    
        def user_params
            params.require( :user ).permit( :email, :password, :password_confirmation, :username )
        end
end
