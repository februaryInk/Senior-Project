class Session

    include ActiveModel::Model

    attr_accessor :email
    attr_accessor :password
    attr_accessor :remember_me
    
    # VALIDATIONS

    validates :email, presence: true
    validates :password, presence: true
    validate  :authentication
    
    # INSTANCE METHODS
    
    private
        
        # If both email and password are present, check that they authenticate.
        def authentication
            return true unless self.email.present? && self.password.present?
            user = User.find_by( { :email => email.downcase } )
            self.errors.add( :base, 'Incorrect email address or password.' ) unless user.present? && user.authenticate( self.password )
        end
end
