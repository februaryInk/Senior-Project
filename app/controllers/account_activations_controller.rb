class AccountActivationsController < DefaultNamespaceController

    # resend the user an activation email, if it is requested.
    def create
        @account_activation = AccountActivation.new( account_activation_params )
        @user = User.find_by( :email => @account_activation.email.downcase )
        
        if @account_activation.valid?
            if @user && !@user.activated?
                @user.send_activation_email
                flash[ :info ] = 'Activation email has been sent. Please check your email inbox.'
                redirect_to( root_path )
            elsif @user && @user.activated?
                flash[ :info ] = 'The account with the given address has already been activated. You should be able to sign in.'
                redirect_to( signin_path )
            else
                flash[ :info ] = 'Activation email has been sent. Please check your email inbox.'
                redirect_to( root_path )
            end
        else
            render( 'new' )
        end
    end

    # use the email response to activate the user's account.
    def edit
        # the email and id params are passed in by the link in the email. the id param 
        # is actually the user's activation_token and should authenticate with their 
        # activation_digest.
        user = User.find_by( :email => params[ :email ] )
        if user && !user.activated? && user.authenticated?( :activation, params[ :id ] )
            user.activate
            sign_in( user )
            flash[ :success ] = 'Your account has been activated.'
            redirect_to( user_path( user ) )
        elsif user && user.activated? && user.authenticated?( :activation, params[ :id ] )
            flash[ :info ] = 'Account has already been activated. You should be able to sign in.'
            redirect_to( signin_path )
        else
            flash[ :danger ] = "Account activation link is invalid. If you believe the link has expired, #{ view_context.link_to 'click here', resend_activation_path( user ) } to send another.".html_safe
            redirect_to( root_path )
        end
    end
    
    # display the account activation email request page.
    def new
        @account_activation = AccountActivation.new
    end
    
    private
    
        def account_activation_params
            params.require( :account_activation ).permit(
                :email
            )
        end
end
