require 'test_helper'

class UsersSignupTest < ActionDispath::IntegrationTest

    def setup
        @user = users( :test_user )
    end
    
    test 'signin when the information is valid' do
        get signin_path
        post signin_path, :session => { :email => @user.email, :password => 'strongpassword' }
        assert_redirected_to user_path( @user )
        follow_redirect!
        assert_template 'users/show'
    end
end 