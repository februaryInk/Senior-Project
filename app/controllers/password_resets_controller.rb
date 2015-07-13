class PasswordResetsController < ApplicationController

    layout 'default'
    include SessionManagement
    
    # BEFORE ACTIONS
    
    before_action :check_expiration, :only => [ :edit, :update ]
    before_action :get_user, :only => [ :edit, :update ]
    before_action :valid_user, :only => [ :edit, :update ]

    # send the user a password reset email if the user exists.
    def create
        @user = User.find_by( :email => params[ :password_reset ][ :email ].downcase )
        if @user && @user.activated?
            @user.create_reset_digest
            @user.send_password_reset_email
            flash[ :info ] = 'Password reset email has been sent.'
            redirect_to root_path
        elsif @user && !@user.activated?
            flash.now[ :info ] = "The account with the given address has not been activated. Please #{ view_context.link_to 'activate it', new_account_activation_path } first.".html_safe
            render 'new'
        else
            flash.now[ :danger ] = 'No account with that address exists.'
            render 'new'
        end
    end
    
    # display the password reset page.
    def edit
    end

    # display the password reset request page.
    def new
    end
    
    # reset the user's password.
    def update
        if @user.update_attributes( user_params )
            sign_in @user
            flash[ :success ] = 'Your password has been reset.'
            redirect_to user_path( @user )
        else
            render 'edit'
        end
    end
    
    private
    
        # redirect if the password reset_token was sent more than 2 hours ago.
        def check_expiration
            if @user.password_reset_expired?
                flash[ :danger ] = 'The password reset link has expired. If you still wish to reset your password, please submit your request again.'
                redirect_to new_password_reset_url
            end
        end
    
        # retrieve the user from the information stored in the reset password link,
        # which the user was sent via email.
        def get_user
            @user = User.find_by( :email => params[ :email ] )
        end
        
        def user_params
            params.require( :user ).permit( :password, :password_confirmation )
        end
        
        # ensure that the user exists, was activated, and that the reset_token passed
        # through the link pairs with the user's reset_digest in the database.
        def valid_user
            unless ( @user && @user.activated? && @user.authenticated?( :reset, params[ :id ] ) )
                redirect_to root_path
            end
        end
end
