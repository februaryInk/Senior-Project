class AccountActivationsController < ApplicationController

    # use the email response to activate the user's account.
    def edit
        # the email and id params are passed in by the link in the email. the id param 
        # is actually the user's activation_token and should authenticate with their 
        # activation_digest.
        user = User.find_by( :email => params[ :email ] )
        if user && !user.activated? && user.authenticated?( :activation, params[ :id ] )
            user.activate
            sign_in user
            flash[ :success ] = 'Your account has been activated.'
            redirect_to user_path( user )
        else
            flash[ :danger ] = 'Account activation link is invalid.'
            redirect_to root_path
        end
    end
end
