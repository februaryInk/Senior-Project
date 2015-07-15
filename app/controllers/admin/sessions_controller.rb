class Admin::SessionsController < AdminNamespaceController

    layout 'simple'

    # sign in the user if all requirements are met.
    def create
        user = User.find_by( :email => params[ :session ][ :email ].downcase )
        if user && user.authenticate( params[ :session ][ :password ] ) && user.admin?
            sign_in user
            redirect_back_or admin_root_path
        else
            # sessions have no model, so errors are passed via the flash. use flash.now 
            # because of the render.
            flash.now[ :session_error ] = 'The supplied email or password is incorrect.'
            render 'new'
        end
    end
    
    # sign out the admin.
    def destroy
        sign_out if signed_in?
        redirect_to root_url
    end
    
    # display the sign in page.
    def new
    end
end
