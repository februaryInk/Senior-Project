module SessionManagementHelper

    # return the current_user, if there is one, by checking the session param or 
    # the remember_token in the browser cookies.
    def current_user
        if session[ :user_id ]
            @current_user ||= User.find_by( :id => session[ :user_id ] )
        elsif cookies.signed[ :user_id ]
            user = User.find_by( :id => cookies.signed[ :user_id ] )
            if user && user.authenticated?( :remember, cookies[ :remember_token ] )
                sign_in user
                @current_user = user
            end
        end
    end
    
    # check if a user is the current_user.
    def current_user?( user )
        user == current_user
    end

    # return true if a user is signed in.
    def signed_in?
        !current_user.nil?
    end
end