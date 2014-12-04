module SessionsHelper
    def current_user
        if session[ :user_id ]
            @current_user ||= User.find_by( :id => session[ :user_id ] )
        elsif cookies.signed[ :user_id ]
            user = User.find_by( :id => cookies.signed[ :user_id ] )
            if user && user.authenticated?( cookies[ :remember_token ] )
                signin user
                @current_user = user
            end
        end
    end
    
    def current_user?( user )
        user == current_user
    end
    
    def forget( user )
        user.forget
        cookies.delete( :user_id )
        cookies.delete( :remember_token )
    end
    
    # Friendly forwards the user, then deletes the now unnecessary storage variable.
    def redirect_back_or( default )
        redirect_to( session[ :forwarding_url ] || default )
        session.delete( :forwarding_url )
    end
    
    def remember( user )
        user.remember
        cookies.permanent.signed[ :user_id ] = user.id
        cookies.permanent[ :remember_token ] = user.remember_token
    end
    
    def signed_in?
        !current_user.nil?
    end

    def signin( user )
        session[ :user_id ] = user.id
    end

    def signin_title
        "#{ site_name } Signin"
    end
    
    def signout
        forget( current_user )
        session.delete( :user_id )
        @current_user = nil
    end
    
    # Stores the URL the user tries to access for friendly forwarding purposes.
    def store_location
        session[ :forwarding_url ] = request.url if request.get?
    end
end
