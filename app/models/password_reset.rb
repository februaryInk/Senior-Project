class PasswordReset

    include ActiveModel::Model

    attr_accessor :email
    
    # VALIDATIONS

    validates :email, presence: true
end
