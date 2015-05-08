# Preview all emails at http://localhost:3000/rails/mailers/automated_user_mailer
class AutomatedUserMailerPreview < ActionMailer::Preview

    # Preview this email at http://localhost:3000/rails/mailers/automated_user_mailer/account_activation
    def account_activation
        user = User.first
        user.activation_token = User.create_token
        AutomatedUserMailer.account_activation( user )
    end

    # Preview this email at http://localhost:3000/rails/mailers/automated_user_mailer/password_reset
    def password_reset
        user = User.first
        user.reset_token = User.create_token
        AutomatedUserMailer.password_reset( user )
    end
end
