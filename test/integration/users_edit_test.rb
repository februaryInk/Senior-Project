require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
    
    def setup
        @user = users( :test_user )
    end
    
    test 'a successful user update without password changes' do
        sign_in_as @user
        get edit_user_path( @user )
        assert_template 'users/edit'
        patch user_path( @user ), :user => { :current_password => 'goodpassword', :username => 'New Name', :email => 'newemail@example.com' }
        follow_redirect!
        assert_template 'users/edit'
        assert_select 'div.flash-success'
        @user.reload
        assert_equal @user.username, 'New Name'
        assert_equal @user.email, 'newemail@example.com'
    end
    
    test 'a successful user update with password changes' do
        sign_in_as @user
        get edit_user_path( @user )
        assert_template 'users/edit'
        patch user_path( @user ), :user => { :current_password => 'goodpassword', :password => 'newpassword', :password_confirmation => 'newpassword' }
        follow_redirect!
        assert_template 'users/edit'
        @user.reload
        assert_select 'div.flash-success'
        assert @user.authenticate( 'newpassword' )
    end
    
    test 'an unsuccessful user update' do
        sign_in_as @user
        get edit_user_path( @user )
        assert_template 'users/edit'
        patch user_path( @user ), :user => { :current_password => 'goodpassword', :username => '', :email => 'newemail@example.com' }
        assert_template 'users/edit'
        @user.reload
        assert_not_equal @user.username, ''
        assert_not_equal @user.email, 'newemail@example.com'
    end
    
    test 'an unsuccessful user update with password changes' do
        sign_in_as @user
        get edit_user_path( @user )
        assert_template 'users/edit'
        patch user_path( @user ), :user => { :current_password => 'goodpassword', :password => 'short', :password_confirmation => 'short' }
        assert_template 'users/edit'
        @user.reload
        assert_not @user.authenticate( 'short' )
    end
end
