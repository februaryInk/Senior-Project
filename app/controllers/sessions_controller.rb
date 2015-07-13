class SessionsController < ApplicationController

    layout 'default.html'
    include SessionManagement
    
    # sign in the user if all requirements are met.
    def create
        user = User.find_by( :email => params[ :session ][ :email ].downcase )
        if user && user.authenticate( params[ :session ][ :password ] )
            # sign the user in only if their account has been authenticated.
            if user.activated?
                sign_in user
                params[ :session ][ :remember_me ] == '1' ? remember( user ) : forget( user )
                redirect_back_or user_path( user )
            else
                # ADD FEATURE: this should give the option to re-send the email.
                flash[ :warning ] = "This account has not been activated. Check your email inbox for the activation link. If you cannot find the email, #{ view_context.link_to( 'click here', new_account_activation_path ) } to send another.".html_safe
                redirect_to root_path
            end
        else
            # sessions have no model, so errors are passed via the flash. use flash.now 
            # because of the render.
            if user
                flash.now[ :session_error ] = 'The supplied password is incorrect.'
            else
                flash.now[ :session_error ] = 'There is no user associated with that email address.'
            end
            render 'new'
        end
    end
    
    # sign out the user.
    def destroy
        sign_out if signed_in?
        redirect_to root_url
    end
    
    # display the sign in page.
    def new
    end
end
