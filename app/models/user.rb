class User < ActiveRecord::Base
    EMAIL_REGEX = /\A([\w+\-.]+)(@)([a-z\d\-]+)(?:\.[a-z\d\-]+)*(\.)([a-z]+)\z/i
    USERNAME_REGEX = /\A(?=.*[a-z0-9].*)([a-z0-9\-_.]+)([\s][a-z0-9\-_.]+)*\z/i
    
    has_secure_password(  ) # creates password and password_confirmation attributes

    validates :email, { :format => { :with => EMAIL_REGEX }, :presence => true, :uniqueness => { :case_sensitive => false } }
    validates :username, { :format => { :with => USERNAME_REGEX }, :length => { :maximum => 32 }, :presence => true }
    validates :password, { :length => { :maximum => 32, :minimum => 10 } }
    validates :simple_name, { :uniqueness => true }
    
    before_validation(  ) { self.simple_name = self.username.downcase.gsub( /[ \-\._\s ]/, "" ) }
    before_save(  ) { self.email = email.downcase(  ) }
end
