module AdminSessionManagement
    
    extend ActiveSupport::Concern

    # return the current_user, if there is one, by checking the session param or 
    # the remember_token in the browser cookies.
    def current_admin_user
        if session[ :admin_user_id ]
            @current_admin_user ||= User.find_by( :id => session[ :admin_user_id ] )
        end
    end
    
    # check if a user is the current_admin_user.
    def current_admin_user?( admin_user )
        user == current_admin_user
    end
    
    # friendly forward the user, then delete the now unnecessary storage variable.
    def redirect_back_or( default )
        redirect_to( session[ :forwarding_url ] || default )
        session.delete( :forwarding_url )
    end
    
    # return true if an admin user is signed in.
    def signed_in?
        !current_admin_user.nil?
    end

    # sign in the user by using Rails's session method.
    def sign_in( admin_user )
        session[ :admin_user_id ] = admin_user.id
    end
    
    # sign the admin user out by deleting their their session.
    def sign_out
        session.delete( :admin_user_id )
        @current_admin_user = nil
    end
    
    # stores the URL the user tries to access for friendly forwarding purposes.
    def store_location
        session[ :forwarding_url ] = request.url if request.get?
    end
end