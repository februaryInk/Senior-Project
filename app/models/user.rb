class User < ActiveRecord::Base

    EMAIL_REGEX = /\A([\w+\-.]+)(@)([a-z\d\-]+)(?:\.[a-z\d\-]+)*(\.)([a-z]+)\z/i
    USERNAME_REGEX = /\A(?=.*[a-z0-9].*)([a-z0-9\-_.]+)([\s][a-z0-9\-_.]+)*\z/i
    
    # creates password and password_confirmation attributes, along with the 
    # authenticate method.
    has_secure_password
    
    # these attributes are not kept in the database, and so are assigned here.
    attr_accessor :activation_token, :remember_token, :reset_token
    
    # VALIDATIONS
    
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
    
    # RELATIONSHIPS
    
    has_many :conversations
    has_many :comments
    has_many :manuscripts, :dependent => :destroy
    has_many :news_reports
    has_many :posts, :dependent => :destroy
    has_many :inklings, :dependent => :destroy
    has_many :sections, :through => :manuscripts
    has_many :feedback
    
    has_many :friendships, :dependent => :destroy
    has_many :reciprocated_friendships, :class_name => 'Friendship', :foreign_key => 'friend_id', :dependent => :destroy
    
    has_many :accepted_friends, -> { where( 'friendships.status = ?', 'accepted' ) }, :through => :friendships
    has_many :friends, :through => :friendships
    has_many :pending_friends, -> { where( 'friendships.status = ?', 'pending' ) }, :through => :friendships
    has_many :waiting_friends, -> { where( 'friendships.status = ?', 'waiting' ) }, :through => :friendships
    
    # BEFORE ACTIONS
    
    before_create :create_activation_digest
    before_validation :assign_simple_name
    before_save(  ) { self.email = email.downcase(  ) }
    
    # CLASS METHODS
    
    # fetch all users who have usernames beginning with a given letter.
    def User.beginning_with( letter )
        User.where( "username LIKE :first", :first => "#{ letter }%" ).order( 'username ASC' )
    end
    
    # generate a random string to be used as a secure token.
    def User.create_token
        SecureRandom.urlsafe_base64
    end
    
    # hash a string with a certain time/complexity cost. generally, the hash is
    # what will be stored in the database for sensitive information rather than
    # the actual string.
    def User.digest( string )
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        BCrypt::Password.create( string, :cost => cost )
    end
    
    # INSTANCE METHODS
    
    # activate the user so they can access their account.
    def activate
        self.update_attributes( :activated => true, activated_at => Time.zone.now )
    end
    
    # fetch the posts that belong in this user's activity feed.
    def activity_feed
        accepted_friends_ids = "SELECT user_id FROM friendships WHERE friend_id = :user_id AND status = 'accepted'"
        Post.where( "user_id IN (#{ accepted_friends_ids }) OR user_id = :user_id", :user_id => self.id )
    end
    
    # determine the user's simple_name and assign it. the simple_name is used to 
    # enforce greater username uniqueness.
    def assign_simple_name
        self.simple_name = self.username.downcase.gsub( /[ \-\._\s ]/, "" )
    end
    
    # check if a given token matches the stored digest. possibilities for attribute
    # are activation, password, remember, and reset.
    def authenticated?( attribute, token )
        digest = send( "#{ attribute }_digest" )
        return false if digest.nil?
        BCrypt::Password.new( digest ).is_password?( token )
    end
    
    # create a password reset token for sending to the user through email, then
    # store the digest in the database.
    def create_reset_digest
        self.reset_token = User.create_token
        update_attributes( :reset_digest => User.digest( reset_token ), :reset_sent_at => Time.zone.now )
    end
    
    # delete a user's remember digest so that they will no longer be signed in.
    def forget
        self.update_attribute( :remember_digest, nil )
    end
    
    # check if another user is this user's friend.
    def friend?( user )
        self.friends.include?( user )
    end
    
    def is_owner?( object )
        owner = object.user
        self == owner
    end
    
    # check if the password reset was sent to the user longer than 2 hours ago.
    def password_reset_expired?
        self.reset_sent_at < 2.hours.ago
    end
    
    # check if another user is this user's friend.
    def pending_friend?( user )
        self.pending_friends.include?( user )
    end
    
    # NOTE: implement this when privacy settings are added.
    # def privacy_settings_allow?( user )
    
    # assign the user a remember_token and store the digest. this is used to keep
    # users signed in even if the browser is closed.
    def remember
        self.remember_token = User.create_token
        self.update_attribute( :remember_digest, User.digest( remember_token ) )
    end
    
    # deliver an email to the user that contains an activation link.
    def send_activation_email
        AutomatedUserMailer.account_activation( self ).deliver
    end
    
    # deliver an email to the user that contains a password reset link.
    def send_password_reset_email
        AutomatedUserMailer.password_reset( self ).deliver
    end
    
    # check if another user is this user's waiting friend.
    def waiting_friend?( user )
        self.waiting_friends.include?( user )
    end
    
    private
    
        # create an activation token for sending to the user through email, then
        # store the digest in the database.
        def create_activation_digest
            self.activation_token = User.create_token
            self.activation_digest = User.digest( activation_token )
        end
        
        # detect if the user is attempting to change their password when updating
        # their account.
        def update_password?
            password.present? || password_confirmation.present?
        end
end
