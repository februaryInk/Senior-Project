require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

    def setup
        @user = users( :test_user )
    end
    
    test 'signin when the information is valid' do
        get signin_path
        post signin_path, :session => { :email => @user.email, :password => 'goodpassword' }
        assert_redirected_to user_path( @user )
        follow_redirect!
        assert_template 'users/show'
        assert_select 'a[href=?]', signin_path, :count => 0
        assert_select 'a[href=?]', signout_path
        assert_select 'a[href=?]', user_path( @user )
        assert is_signed_in?
    end
    
    test 'signin followed by a signout' do
        get signin_path
        post signin_path, :session => { :email => @user.email, :password => 'goodpassword' }
        assert is_signed_in?
        assert_redirected_to user_path( @user )
        follow_redirect!
        assert_template 'users/show'
        assert_select 'a[href=?]', signin_path, :count => 0
        assert_select 'a[href=?]', signout_path
        assert_select 'a[href=?]', user_path( @user )
        delete signout_path
        assert_not is_signed_in?
        assert_redirected_to root_path
        follow_redirect!
        assert_select 'a[href=?]', signin_path
        assert_select 'a[href=?]', signout_path, :count => 0
        assert_select 'a[href=?]', user_path( @user ), :count => 0
    end
    
    test 'signin with "remember me"' do
        sign_in_as( @user, :remember_me => 1 )
        assert_not_nil cookies[ 'remember_token' ]
    end
    
    test 'signin without "remember me"' do
        sign_in_as( @user, :remember_me => 0 )
        assert_nil cookies[ 'remember_token' ]
    end
    
    test 'signin when the information is not valid' do
        get signin_path
        assert_template 'sessions/new'
        post signin_path, :session => { :email => @user.email, :password => 'wrongpassword' }
        assert_template 'sessions/new'
        assert_select 'p.t-danger'
    end
end 