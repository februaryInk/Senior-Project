class UsersController < ApplicationController
    layout 'default.html'

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
    
        def user_params
            params.require( :user ).permit( :email, :password, :password_confirmation, :username )
        end
end
