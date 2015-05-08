class SessionsController < ApplicationController
    layout 'default.html'
    
    def create
        user = User.find_by( :email => params[ :session ][ :email ].downcase )
        if user && user.authenticate( params[ :session ][ :password ] )
            if user.activated?
                signin user
                params[ :session ][ :remember_me ] == '1' ? remember( user ) : forget( user )
                redirect_back_or user_path( user )
            else
                flash[ :warning ] = 'This account has not been activated. Check your email for the activation link.'
                redirect_to root_path
            end
        else
            if user
                flash.now[ :session_error ] = 'The supplied password is incorrect.'
            else
                flash.now[ :session_error ] = 'There is no user associated with that email address.'
            end
            render 'new'
        end
    end
    
    def destroy
        signout if signed_in?
        redirect_to root_url
    end
    
    def new
    end
end
