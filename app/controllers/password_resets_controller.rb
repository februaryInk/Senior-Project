class PasswordResetsController < ApplicationController

    layout 'default'
    
    before_action :check_expiration, :only => [ :edit, :update ]
    before_action :get_user, :only => [ :edit, :update ]
    before_action :valid_user, :only => [ :edit, :update ]

    def create
        @user = User.find_by( :email => params[ :password_reset ][ :email ].downcase )
        if @user
            @user.create_reset_digest
            @user.send_password_reset_email
            flash[ :info ] = 'Password reset email has been sent.'
            redirect_to root_path
        else
            flash.now[ :danger ] = 'No account with that address exists.'
            render 'new'
        end
    end
    
    def edit
    end

    def new
    end
    
    def update
        if @user.update_attributes( user_params )
            signin @user
            flash[ :success ] = 'Your password has been reset.'
            redirect_to user_path( @user )
        else
            render 'edit'
        end
    end
    
    private
    
        def check_expiration
            if @user.password_reset_expired?
                flash[ :danger ] = 'The password reset link has expired. If you still wish to reset your password, please submit your request again.'
                redirect_to new_password_reset_url
            end
        end
    
        def get_user
            @user = User.find_by( :email => params[ :email ] )
        end
        
        def user_params
            params.require( :user ).permit( :password, :password_confirmation )
        end
        
        def valid_user
            unless ( @user && @user.activated? && @user.authenticated?( :reset, params[ :id ] ) )
                redirect_to root_path
            end
        end
end
