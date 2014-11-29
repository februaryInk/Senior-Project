class User < ActiveRecord::Base
    EMAIL_REGEX = /\A([\w+\-.]+)(@)([a-z\d\-]+)(?:\.[a-z\d\-]+)*(\.)([a-z]+)\z/i
    USERNAME_REGEX = /\A(?=.*[a-z0-9].*)([a-z0-9\-_.]+)([\s][a-z0-9\-_.]+)*\z/i
    
    has_secure_password # creates password and password_confirmation attributes
    attr_accessor :remember_token
    
    has_many :conversations
    has_many :comments
    
    validates :email, { :format => { :with => EMAIL_REGEX }, :presence => true, :uniqueness => { :case_sensitive => false } }
    validates :username, { :format => { :with => USERNAME_REGEX }, :length => { :maximum => 32 }, :presence => true }
    validates :password, { :length => { :maximum => 32, :minimum => 10 } }
    validates :simple_name, { :uniqueness => true }
    
    before_validation(  ) { self.simple_name = self.username.downcase.gsub( /[ \-\._\s ]/, "" ) }
    before_save(  ) { self.email = email.downcase(  ) }
    
    def authenticated?( remember_token )
        return false if remember_digest.nil?
        BCrypt::Password.new( remember_digest ).is_password?( remember_token )
    end
    
    def forget
        update_attribute( :remember_digest, nil )
    end
    
    def remember
        self.remember_token = User.create_token
        update_attribute( :remember_digest, User.digest( remember_token ) )
    end
    
    def User.create_token
        SecureRandom.urlsafe_base64
    end
    
    def User.digest( string )
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        BCrypt::Password.create( string, :cost => cost )
    end
end
