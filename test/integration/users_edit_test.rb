require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
    
    def setup
        @user = users( :test_user )
    end
    
    test 'an unsuccessful user edit' do
        sign_in_as @user
        get edit_user_path( @user )
        assert_template 'users/edit'
        patch user_path( @user ), :authentication => { :password => 'goodpassword' }, :user => { :name => '', :email => 'newemail@example.com' }
        assert_not_equal @user.email, 'newemail@example.com'
        assert_template 'users/edit'
    end
end
