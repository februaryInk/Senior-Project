class User < ActiveRecord::Base
    EMAIL_REGEX = /\A([\w+\-.]+)(@)([a-z\d\-]+)(?:\.[a-z\d\-]+)*(\.)([a-z]+)\z/i
    USERNAME_REGEX = /\A(?=.*[a-z0-9].*)([a-z0-9\-_.]+)([\s][a-z0-9\-_.]+)*\z/i
    
    # creates password and password_confirmation attributes
    has_secure_password
    attr_accessor :remember_token
    
    has_many :conversations
    has_many :comments
    has_many :manuscripts, :dependent => :destroy
    has_many :news_reports
    has_many :inklings, :dependent => :destroy
    has_many :sections, :dependent => :destroy
    
    has_many :friendships, :dependent => :destroy
    has_many :reciprocated_friendships, :class_name => 'Friendship', :foreign_key => 'friend_id', :dependent => :destroy
    
    has_many :accepted_friends, -> { where( 'friendships.status = ?', 'accepted' ) }, :through => :friendships
    has_many :friends, :through => :friendships
    has_many :pending_friends, -> { where( 'friendships.status = ?', 'pending' ) }, :through => :friendships
    has_many :waiting_friends, -> { where( 'friendships.status = ?', 'waiting' ) }, :through => :friendships
    
    # allow_blank => true on the password validations only works on PATCH requests.
    # has_secure_password still prevents truly blank passwords on POST requests.
    # with the addition of the custom reduce validator, validations must be put in
    # the order that the error messages should come, i.e., blank before invalid.
    # always put :reduce last to display at most 1 error for each attribute.
    validates :email, { :presence => true, :format => { :with => EMAIL_REGEX }, :uniqueness => { :case_sensitive => false }, :reduce => true }
    validates :username, { :presence => true, :length => { :maximum => 32 }, :format => { :with => USERNAME_REGEX }, :reduce => true }
    validates :password, { :length => { :maximum => 32, :minimum => 8 }, :allow_blank => true, :reduce => true }
    validates :simple_name, { :uniqueness => true }
    
    before_validation(  ) { self.simple_name = self.username.downcase.gsub( /[ \-\._\s ]/, "" ) }
    before_save(  ) { self.email = email.downcase(  ) }
    
    # class methods
    
    def authenticated?( remember_token )
        return false if remember_digest.nil?
        BCrypt::Password.new( remember_digest ).is_password?( remember_token )
    end
    
    def forget
        update_attribute( :remember_digest, nil )
    end
    
    def friend?( user )
        friends.include?( user )
    end
    
    def pending_friend?( user )
        pending_friends.include?( user )
    end
    
    def remember
        self.remember_token = User.create_token
        update_attribute( :remember_digest, User.digest( remember_token ) )
    end
    
    def waiting_friend?( user )
        waiting_friends.include?( user )
    end
    
    # instance methods
    
    def User.create_token
        SecureRandom.urlsafe_base64
    end
    
    def User.digest( string )
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        BCrypt::Password.create( string, :cost => cost )
    end
end
