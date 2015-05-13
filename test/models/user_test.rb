require 'test_helper'

class UserTest < ActiveSupport::TestCase
    
    def setup
        @user = User.new( :email => 'newuser@example.com', :password => 'strongpassword', :password_confirmation => 'strongpassword', :username => 'New User' )
    end
    
    test 'should be valid' do
        assert @user.valid?
    end
    
    test 'username should be present' do
        @user.username = '   '
        assert_not @user.valid?
    end
    
    test 'username that must be unique' do
        duplicate_name_user = @user.dup
        duplicate_name_user.email = 'otheremail@example.com'
        duplicate_name_user.username = @user.username.upcase
        @user.save
        assert_not duplicate_name_user.valid?
        
        duplicate_name_user.username = "-- #{ @user.username }-.-"
        assert_not duplicate_name_user.valid?
    end
    
    test 'username should not be more than 32 characters' do
        @user.username = 'a' * 33
        assert_not @user.valid?
    end
    
    test 'username should register as valid if it has a valid format' do
        valid_usernames = [ "Alpha Beta", "7Alpha.Beta", "..Gamma9", "--Gamma--", "777" ]        
        valid_usernames.each do | username |
            @user.username = username
            assert @user.valid?, "#{ username.inspect } should be valid"
        end
    end
    
    test 'username should register as invalid if it has an invalid format' do
        invalid_usernames = [ "Alpha Beta ", " Alpha Beta", "$amma", "@#!&%", "-.-" ]        
        invalid_usernames.each do | username |
            @user.username = username
            assert_not @user.valid?, "#{ username.inspect } should be invalid"
        end
    end
    
    test 'email should be present' do
        @user.email = '   '
        assert_not @user.valid?
    end
    
    test 'email should be unique, even with regard to case' do
        duplicate_email_user = @user.dup
        duplicate_email_user.email = @user.email.upcase
        duplicate_email_user.username = 'Some Other username'
        @user.save
        assert_not duplicate_email_user.valid?
    end
    
    test 'email should not be more than 255 characters' do
        @user.username = 'a' * 256
        assert_not @user.valid?
    end
    
    test 'email should register as valid if it has a valid format' do
        valid_addresses = %w[ user@alpha.COM A_US-ER@f.b.org frst.lst@alpha.jp a+b@gamma.cn ]
        
        valid_addresses.each do | address |
            @user.email = address
            assert @user.valid?, "#{ address.inspect } should be valid"
        end
    end
    
    test 'email should register as invalid if it has an invalid format' do
        invalid_addresses = %w[ alpha@beta..com user@alpha,com user_at_alpha.org example.user@alpha. alpha@beta_gamma.com alpha@beta+gamma.com ]
        
        invalid_addresses.each do | address |
            @user.email = address
            assert_not @user.valid?, "#{ address.inspect } should be invalid"
        end
    end
    
    test 'email should be downcased on save' do
        mixed_case_email = 'User@Example.com'
        @user.email = mixed_case_email
        @user.save
        assert_equal mixed_case_email.downcase, @user.reload.email
    end
    
    test 'password should be present upon saving' do
        @user.password = ' ' * 10
        @user.password_confirmation = ' ' * 10
        assert_not @user.save
    end
    
    test 'password should have at least 8 characters' do
        @user.password = 'a' * 7
        @user.password_confirmation = 'a' * 7
        assert_not @user.valid?
    end
    
    test 'password should have at most 32 characters' do
        @user.password = 'a' * 33
        @user.password_confirmation = 'a' * 33
        assert_not @user.valid?
    end
end
