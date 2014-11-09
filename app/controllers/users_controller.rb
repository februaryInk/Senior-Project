class UsersController < ApplicationController

    def create
        @user = User.new( user_params )
        if @user.save
            redirect_to user_url( @user )
        else
            render new
        end
    end
    
    def edit
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
    
    private
    
        def user_params
            params.require( :user ).permit( :email, :password, :password_confirmation, :username )
        end
end
