class AutomatedUserMailer < ApplicationMailer

    include ApplicationHelper

    default :from => 'inklings.com'

    # delivers an account activation link to users on signup.
    def account_activation( user )
        # site_name method is not available in the mailer views; since they have no
        # controller, assign it here.
        @site_name = site_name
        @user = user
        mail to: user.email, :subject => "#{ site_name } Account Activation"
    end

    # delivers a password reset link to users on request.
    def password_reset( user )
        @site_name = site_name
        @user = user
        mail :to => user.email, :subject => "#{ site_name } Password Reset"
    end
end
