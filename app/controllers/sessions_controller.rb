class SessionsController < ApplicationController
    def create
        user = User.find_by( :email => params[ :session ][ :email ].downcase )
        if user && user.authenticate( params[ :session ][ :password ] )
            signin user
            params[ :session ][ :remember_me ] == '1' ? remember( user ) : forget( user )
            redirect_to user_path( user )
        else
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
