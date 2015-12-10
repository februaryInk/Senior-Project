class Admin::SessionsController < AdminNamespaceController

    layout 'simple'

    # sign in the user if all requirements are met.
    def create
        @session = Session.new( session_params )
        user = User.find_by( :email => @session.email.downcase )
        if user.admin?
            if @session.valid?
                # sign the user in only if their account has been authenticated.
                if user.activated?
                    sign_in( user )
                    redirect_back_or( admin_root_path )
                else
                    flash[ :warning ] = "This account has not been activated. Check your email inbox for the activation link. If you cannot find the email, #{view_context.link_to( 'click here', new_account_activation_path )} to send another.".html_safe
                    redirect_to( root_path )
                end
            else
                render( 'new' )
            end
        else
            flash[ :warning ] = 'You are not authorized to sign into the admin portal. Please sign in here instead.'
            redirect_to( signin_path )
        end
    end
    
    # sign out the admin.
    def destroy
        sign_out if signed_in?
        redirect_to root_url
    end
    
    # display the sign in page.
    def new
        @session = Session.new
    end
    
    private
    
        def session_params
            params.require( :session ).permit( 
                :email,
                :password
            )
        end
end
