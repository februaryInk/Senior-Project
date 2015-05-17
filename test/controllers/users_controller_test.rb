require 'test_helper'

class UsersControllerTest < ActionController::TestCase

    def setup
        @user = users( :test_user )
        @admin_user = users( :admin_user )
        @other_user = users( :other_user )
    end

    test 'should get edit' do
        sign_in_as @user
        get :edit, :id => @user.id
        assert_response :success
        assert_select 'title', users_account_title
    end
    
    test 'should redirect if a user attempts to access someone else\'s edit page' do
        sign_in_as @user
        get :edit, :id => @other_user.id
        assert_response 302
        assert_redirected_to root_path
    end

    test 'should get index' do
        sign_in_as @admin_user
        get :index
        assert_response :success
        assert_select 'title', users_index_title
    end

    test 'should get show' do
        get :show, :id => @user.id
        assert_response :success
        assert_select 'title', users_show_title
    end
    
    test 'should redirect if a user attempts to update another\s account' do
        sign_in_as @user
        patch :update, :id => @other_user.id, :user => { :name => @user.username, :email => @user.email }
        assert_response 302
        assert_redirected_to root_path
    end
    
    test 'should not permit users to update their own admin status' do
        sign_in_as @user
        assert_not @user.admin?
        patch :update, :id => @user.id, :authentication => { :password => 'goodpassword' }, :user => { :admin => true }
        assert_not @user.admin?
    end
end
