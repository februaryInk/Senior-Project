module SessionsHelper
    def current_user
        @current_user ||= User.find_by( :id => session[ :user_id ] )
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
        session.delete( :user_id )
        @current_user = nil
    end
end
