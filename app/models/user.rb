class User < ActiveRecord::Base
    EMAIL_REGEX = /\A([\w+\-.]+)(@)([a-z\d\-]+)(?:\.[a-z\d\-]+)*(\.)([a-z]+)\z/i
    USERNAME_REGEX = /\A(?=.*[a-z0-9].*)([a-z0-9\-_.]+)([\s][a-z0-9\-_.]+)*\z/i
    
    # creates password and password_confirmation attributes.
    has_secure_password
    
    # these attributes are not kept in the database, and so are assigned here.
    attr_accessor :activation_token, :remember_token, :reset_token
    
    has_many :conversations
    has_many :comments
    has_many :manuscripts, :dependent => :destroy
    has_many :news_reports
    has_many :inklings, :dependent => :destroy
    has_many :sections, :dependent => :destroy
    has_many :feedback
    
    has_many :friendships, :dependent => :destroy
    has_many :reciprocated_friendships, :class_name => 'Friendship', :foreign_key => 'friend_id', :dependent => :destroy
    
    has_many :accepted_friends, -> { where( 'friendships.status = ?', 'accepted' ) }, :through => :friendships
    has_many :friends, :through => :friendships
    has_many :pending_friends, -> { where( 'friendships.status = ?', 'pending' ) }, :through => :friendships
    has_many :waiting_friends, -> { where( 'friendships.status = ?', 'waiting' ) }, :through => :friendships
    
    # validations
    
    # with the addition of the custom reduce validator, validations must be put in
    # the order that the error messages should come, i.e., blank before invalid.
    # always put :reduce last to display at most 1 error for each attribute.
    # password requires slightly different validations on create versus on update,
    # so that a blank password on update is allowed and leaves the password 
    # unchanged.
    validates :email, { :presence => true, :format => { :with => EMAIL_REGEX }, :uniqueness => { :case_sensitive => false }, :reduce => true }
    validates :username, { :presence => true, :length => { :maximum => 32 }, :format => { :with => USERNAME_REGEX }, :reduce => true }
    validates :password, { :presence => true, :length => { :maximum => 32, :minimum => 8 }, :reduce => true, :on => :create }
    validates :password, { :length => { :maximum => 32, :minimum => 8 }, :reduce => true, :on => :update, :if => :update_password? }
    validates :simple_name, { :uniqueness => true }
    
    before_create :create_activation_digest
    before_validation(  ) { self.simple_name = self.username.downcase.gsub( /[ \-\._\s ]/, "" ) }
    before_save(  ) { self.email = email.downcase(  ) }
    
    # class methods
    
    def User.create_token
        SecureRandom.urlsafe_base64
    end
    
    def User.digest( string )
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        BCrypt::Password.create( string, :cost => cost )
    end
    
    # instance methods
    
    def activate
        self.update_attributes( :activated => true, activated_at => Time.zone.now )
    end
    
    def authenticated?( attribute, token )
        digest = send( "#{ attribute }_digest" )
        return false if digest.nil?
        BCrypt::Password.new( digest ).is_password?( token )
    end
    
    def create_reset_digest
        self.reset_token = User.create_token
        update_attributes( :reset_digest => User.digest( reset_token ), :reset_sent_at => Time.zone.now )
    end
    
    def forget
        update_attribute( :remember_digest, nil )
    end
    
    def friend?( user )
        friends.include?( user )
    end
    
    def password_reset_expired?
        self.reset_sent_at < 2.hours.ago
    end
    
    def pending_friend?( user )
        pending_friends.include?( user )
    end
    
    def remember
        self.remember_token = User.create_token
        update_attribute( :remember_digest, User.digest( remember_token ) )
    end
    
    def send_activation_email
        AutomatedUserMailer.account_activation( self ).deliver
    end
    
    def send_password_reset_email
        AutomatedUserMailer.password_reset( self ).deliver
    end
    
    def waiting_friend?( user )
        waiting_friends.include?( user )
    end
    
    private
    
        def create_activation_digest
            self.activation_token = User.create_token
            self.activation_digest = User.digest( activation_token )
        end
        
        def update_password?
            password.present? || password_confirmation.present?
        end
end
