require 'test_helper'

class UserTest < ActiveSupport::TestCase
    
    def setup
        @friend_of_test_user = users( :friend_of_test_user )
        @not_friend_of_test_user = users( :not_friend_of_test_user )
        @other_user = users( :other_user )
        @pending_friend_of_test_user = users( :pending_friend_of_test_user )
        @remembered_user = users( :remembered_user )
        @test_user = users( :test_user )
        @unactivated_user = users( :unactivated_user )
        @unremembered_user = users( :unremembered_user )
    end
    
    test 'should be valid' do
        assert @test_user.valid?
    end
    
    # VALIDATIONS
    
    test 'email should be present' do
        @test_user.email = '   '
        assert_not @test_user.valid?
    end
    
    test 'email should register as valid if it has a valid format' do
        valid_addresses = %w[ user@alpha.COM A_US-ER@f.b.org frst.lst@alpha.jp a+b@gamma.cn ]
        
        valid_addresses.each do | address |
            @test_user.email = address
            assert @test_user.valid?, "#{ address.inspect } should be valid"
        end
    end
    
    test 'email should register as invalid if it has an invalid format' do
        invalid_addresses = %w[ alpha@beta..com user@alpha,com user_at_alpha.org example.user@alpha. alpha@beta_gamma.com alpha@beta+gamma.com ]
        
        invalid_addresses.each do | address |
            @test_user.email = address
            assert_not @test_user.valid?, "#{ address.inspect } should be invalid"
        end
    end
    
    test 'email should be unique, even with regard to case' do
        duplicate_email_user = @test_user.dup
        duplicate_email_user.email = @test_user.email.upcase
        duplicate_email_user.username = 'Some Other username'
        @test_user.save
        assert_not duplicate_email_user.valid?
    end
    
    test 'username should be present' do
        @test_user.username = '   '
        assert_not @test_user.valid?
    end
    
    test 'username should not be more than 32 characters' do
        @test_user.username = 'a' * 33
        assert_not @test_user.valid?
    end
    
    test 'username should register as valid if it has a valid format' do
        valid_usernames = [ "Alpha Beta", "7Alpha.Beta", "..Gamma9", "--Gamma--", "777" ]        
        valid_usernames.each do | username |
            @test_user.username = username
            assert @test_user.valid?, "#{ username.inspect } should be valid"
        end
    end
    
    test 'username should register as invalid if it has an invalid format' do
        invalid_usernames = [ "Alpha Beta ", " Alpha Beta", "$amma", "@#!&%", "-.-" ]        
        invalid_usernames.each do | username |
            @test_user.username = username
            assert_not @test_user.valid?, "#{ username.inspect } should be invalid"
        end
    end
    
    test 'username should be unique because of simple_name' do
        duplicate_name_user = @test_user.dup
        duplicate_name_user.email = 'otheremail@example.com'
        duplicate_name_user.username = @test_user.username.upcase
        @test_user.save
        assert_not duplicate_name_user.valid?
        
        duplicate_name_user.username = "-- #{ @test_user.username }-.-"
        assert_not duplicate_name_user.valid?
        assert_equal duplicate_name_user.simple_name, @test_user.simple_name
    end
    
    test 'password should be present upon create' do
        new_user = User.new( :email => 'newuser@example.com', :password => ' ' * 10, :password_confirmation => ' ' * 10, :username => 'New User' )
        assert_not new_user.save
    end
    
    test 'password should have at least 8 characters' do
        @test_user.password = 'a' * 7
        @test_user.password_confirmation = 'a' * 7
        assert_not @test_user.valid?
    end
    
    test 'password should have at most 32 characters' do
        @test_user.password = 'a' * 33
        @test_user.password_confirmation = 'a' * 33
        assert_not @test_user.valid?
    end
    
    # BEFORE ACTIONS
    
    test 'simple_name should be assigned before validations' do
        new_user = User.new( :email => 'newuser@example.com', :password => 'goodpassword', :password_confirmation => 'goodpassword', :username => 'New User' )
        assert_nil new_user.simple_name
        new_user.validate
        assert_not_nil new_user.simple_name
    end
    
    test 'activation_digest should be assigned on create' do
        new_user = User.new( :email => 'newuser@example.com', :password => 'goodpassword', :password_confirmation => 'goodpassword', :username => 'New User' )
        assert_nil new_user.activation_digest
        new_user.save
        assert_not_nil new_user.activation_digest
    end
    
    test 'email should be downcased on save' do
        mixed_case_email = 'User@Example.com'
        @test_user.email = mixed_case_email
        @test_user.save
        assert_equal mixed_case_email.downcase, @test_user.reload.email
    end
    
    # INSTANCE METHODS
    
    test 'activate should make activated true' do
        assert_not @unactivated_user.activated?
        @unactivated_user.activate
        assert @unactivated_user.activated?
    end
    
    test 'activity_feed should fetch posts by the user and their friends' do
        expected_user_ids = @test_user.accepted_friend_ids << @test_user.id
        posts = @test_user.activity_feed
        posts.each do | post |
            assert expected_user_ids.include? post.user_id
        end
    end
    
    test 'assign_simple_name should deduce and assign the user\'s simple_name' do
        named_user = User.new( :username => 'U--ser . N--ame' )
        named_user.assign_simple_name
        assert_equal 'username', named_user.simple_name
    end
    
    test 'authenticated? should check that a token matches its digest' do
        assert @test_user.authenticated?( :remember, 'remember_token' )
    end
    
    test 'create_reset_digest should set a reset_token that authenticates with the user\'s reset_digest' do
        @test_user.reset_token = nil
        @test_user.reset_digest = nil
        @test_user.create_reset_digest
        assert_not_nil @test_user.reset_digest
        assert @test_user.authenticated?( :reset, @test_user.reset_token )
    end
    
    test 'forget should remove a user\'s reset_digest' do
        assert_not_nil @remembered_user.remember_digest
        @remembered_user.forget
        assert_nil @remembered_user.remember_digest
    end
    
    test 'friend? should return true if a given user is this user\'s friend' do
        assert @test_user.friend?( @friend_of_test_user )
    end
    
    test 'is_owner? should check if and only if a user owns some object' do
        post = @test_user.posts.build( :content => 'alpha' )
        post.save
        post.reload
        assert @test_user.is_owner?( post )
        other_post = @other_user.posts.build( :content => 'beta' )
        other_post.save
        other_post.reload
        assert_not @test_user.is_owner?( other_post )
    end
    
    test 'password_reset_expired? should return true if and only if a reset_digest is not expired' do
        assert_not @test_user.password_reset_expired?
        @test_user.update_attribute( :reset_sent_at, 3.hours.ago )
        assert @test_user.password_reset_expired?
    end
    
    test 'pending_friend? should return true if a given user is this user\'s pending friend' do
        assert @test_user.pending_friend?( @pending_friend_of_test_user )
    end
    
    test 'remember should should set a remember_token that authenticates with the user\'s remember_digest' do
        @unremembered_user.remember
        assert_not_nil @unremembered_user.remember_digest
        assert @unremembered_user.authenticated?( :remember, @unremembered_user.remember_token )
    end
    
    test 'send_activation_email should send the user an activation email' do
        assert_difference 'ActionMailer::Base.deliveries.count', 1 do
            @unactivated_user.send_activation_email
        end
        #mail = ActionMailer::Base.deliveries.last
        #assert_equal 'unactivateduser@example.com', mail[ :to ].to_s
        #assert_equal "#{ site_name } Account Activation", mail[ :subject ].to_s
    end
    
    test 'send_password_reset_email should send the user a password reset email' do
        assert_difference 'ActionMailer::Base.deliveries.count', 1 do
            @unactivated_user.send_password_reset_email
        end
        mail = ActionMailer::Base.deliveries.last
        assert_equal 'unactivateduser@example.com', mail[ :to ].to_s
        assert_equal "#{ site_name } Password Reset", mail[ :subject ].to_s
    end
    
    test 'waiting_friend? should return true if a given user is this user\'s waiting friend' do
        assert @pending_friend_of_test_user.waiting_friend?( @test_user )
    end
end
