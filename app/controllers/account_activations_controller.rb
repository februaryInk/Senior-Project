class AccountActivationsController < ApplicationController

    def edit
        user = User.find_by( :email => params[ :email ] )
        if user && !user.activated? && user.authenticated?( :activation, params[ :id ] )
            user.activate
            signin user
            flash[ :success ] = 'Your account has been activated.'
            redirect_to user_path( user )
        else
            flash[ :danger ] = 'Account activation link is invalid.'
            redirect_to root_path
        end
    end
end
