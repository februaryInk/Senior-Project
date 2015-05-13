require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
    
    test 'valid signup information' do
        get root_path
        assert_difference 'User.count', 1 do
            post users_path, :user => { :email => 'valid@example.com', :password => 'goodpassword', :password_confirmation => 'goodpassword', :username => 'Good User' }
        end
        follow_redirect!
        assert_template 'core_pages/home'
        assert_select 'div.alert-info'
        assert_select 'div.div-errors', :count => 0
    end
    
    test 'invalid signup information' do
        get root_path
        assert_no_difference 'User.count' do
            post users_path, :user => { :email => 'not.an@email', :password => 'bad', :password_confirmation => 'bad', :username => '' }, :format => 'js'
        end
        assert_template 'users/_new'
    end
end
