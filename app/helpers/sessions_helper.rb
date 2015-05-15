module SessionsHelper

    # return the current_user, if there is one, by checking the session param or 
    # the remember_token in the browser cookies.
    def current_user
        if session[ :user_id ]
            @current_user ||= User.find_by( :id => session[ :user_id ] )
        elsif cookies.signed[ :user_id ]
            user = User.find_by( :id => cookies.signed[ :user_id ] )
            if user && user.authenticated?( :remember, cookies[ :remember_token ] )
                signin user
                @current_user = user
            end
        end
    end
    
    # check if a user is the current_user.
    def current_user?( user )
        user == current_user
    end
    
    # forget a user by deleting their remember_token from the browser.
    def forget( user )
        cookies.delete( :user_id )
        cookies.delete( :remember_token )
    end
    
    # friendly forward the user, then delete the now unnecessary storage variable.
    def redirect_back_or( default )
        redirect_to( session[ :forwarding_url ] || default )
        session.delete( :forwarding_url )
    end
    
    # store a remember_token in the browser so that the user will stay signed in 
    # even when the browser is closed.
    def remember( user )
        user.remember
        cookies.permanent.signed[ :user_id ] = user.id
        cookies.permanent[ :remember_token ] = user.remember_token
    end
    
    # return true if a user is signed in.
    def signed_in?
        !current_user.nil?
    end

    # sign in the user by using Rails's session method.
    def signin( user )
        session[ :user_id ] = user.id
    end

    def signin_title
        "#{ site_name } Signin"
    end
    
    # sign the user out by deleting their remember_token cookie (if there is one)
    # and their session.
    def signout
        forget( current_user )
        session.delete( :user_id )
        @current_user = nil
    end
    
    # stores the URL the user tries to access for friendly forwarding purposes.
    def store_location
        session[ :forwarding_url ] = request.url if request.get?
    end
end
