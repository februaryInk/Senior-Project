class SessionsController < DefaultNamespaceController

    layout( 'simple.html.haml' )
    
    # sign in the user if all requirements are met.
    def create
        @session = Session.new( session_params )
        user = User.find_by( :email => @session.email.downcase )
        if @session.valid?
            # sign the user in only if their account has been authenticated.
            if user.activated?
                sign_in( user )
                @session.remember_me == '1' ? remember( user ) : forget( user )
                redirect_back_or( user_path( user ) )
            else
                flash[ :warning ] = "This account has not been activated. Check your email inbox for the activation link. If you cannot find the email, #{view_context.link_to( 'click here', new_account_activation_path )} to send another.".html_safe
                redirect_to( root_path )
            end
        else
            render( 'new' )
        end
    end
    
    # sign out the user.
    def destroy
        sign_out if signed_in?
        redirect_to( root_url )
    end
    
    # display the sign in page.
    def new
        @session = Session.new
    end
    
    private
    
        def session_params
            params.require( :session ).permit( 
                :email,
                :password,
                :remember_me
            )
        end
end
