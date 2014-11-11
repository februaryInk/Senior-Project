module SessionsHelper
    def current_user
        if session[ :user_id ]
            @current_user ||= User.find_by( :id => session[ :user_id ] )
        elsif cookies.signed[ :user_id ]
            user = User.find_by( :id => cookies.signed[ :user_id ] )
            if user && user.authenticated?( cookies[ :remember_token ] )
                log_in user
                @current_user = user
            end
        end
    end
    
    def forget( user )
        user.forget
        cookies.delete( :user_id )
        cookies.delete( :remember_token )
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
end
