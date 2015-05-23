require 'test_helper'

class UsersControllerTest < ActionController::TestCase

    def setup
        @test_user = users( :test_user )
        @admin_user = users( :admin_user )
        @other_user = users( :other_user )
    end
    
    # CREATE
    
    test 'should create a user and send them an activation email' do
        assert_difference 'User.count', 1 do
            post :create, :user => { :email => 'newuser@example.com', :password => 'goodpassword', :password_confirmation => 'goodpassword', :username => 'New User' }
        end
        assert_response :found
        assert_not_nil User.find_by( :email => 'newuser@example.com' )
        mail = ActionMailer::Base.deliveries.last
        assert_equal 'newuser@example.com', mail[ :to ].to_s
        assert_equal "#{ site_name } Account Activation", mail[ :subject ].to_s
    end
    
    # DESTROY
    
    test 'should destroy a user when they delete their own account' do
        sign_in_as @test_user
        assert_difference 'User.count', -1 do
            delete :destroy, :id => @test_user.id
        end
        assert_nil User.find_by( :email => 'testuser@example.com' )
    end
    
    test 'should destroy a user when an admin deletes their account' do
        sign_in_as @admin_user
        assert_difference 'User.count', -1 do
            delete :destroy, :id => @test_user.id
        end
        assert_nil User.find_by( :email => 'testuser@example.com' )
    end
    
    test 'should redirect a user who attempts to delete someone else\'s account' do
        sign_in_as @other_user
        assert_no_difference 'User.count' do
            delete :destroy, :id => @test_user.id
        end
        assert_not_nil User.find_by( :email => 'testuser@example.com' )
        assert_redirected_to root_path
    end
    
    # EDIT

    test 'should get edit' do
        sign_in_as @test_user
        get :edit, :id => @test_user.id
        assert_response :success
        assert_template 'users/edit'
        assert_select 'title', users_account_title
    end
    
    test 'should redirect if a user attempts to access someone else\'s edit page' do
        sign_in_as @test_user
        get :edit, :id => @other_user.id
        assert_response 302
        assert_redirected_to root_path
    end
    
    # INDEX

    test 'should get index with all users with usernames beginning with "a" displayed by default' do
        sign_in_as @admin_user
        get :index
        assert_response :success
        assert_template 'users/index'
        assert_select 'title', users_index_title
        User.beginning_with( 'a' ).paginate( :page => 1 ).each do | user |
            assert_match user.username, response.body
        end
    end
    
    test 'should redirect if a non-admin attempts to access the index page' do
        sign_in_as @test_user
        get :index
        assert_response 302
        assert_redirected_to user_path( @test_user )
    end
    
    # MANUSCRIPTS
    
    test 'should get manuscripts' do
        sign_in_as @test_user
        get :manuscripts, :id => @test_user.id
        assert_response :success
        assert_template 'users/manuscripts'
        assert_select 'title', users_account_title
        @test_user.manuscripts.each do | manuscript |
            assert_match manuscript.title, response.body
        end
    end
    
    test 'should redirect if a user attempts to access another\'s manuscripts' do
        sign_in_as @other_user
        get :manuscripts, :id => @test_user.id
        assert_response 302
        assert_redirected_to root_path
    end
    
    # SHOW

    test 'should get show' do
        get :show, :id => @test_user.id
        assert_response :success
        assert_template 'users/show'
        assert_select 'title', users_show_title
    end
    
    # SOCIAL
    
    test 'should get social' do
        sign_in_as @test_user
        get :social, :id => @test_user.id
        assert_response :success
        assert_template 'users/social'
        assert_select 'title', users_account_title
    end
    
    test 'should redirect if a user attempts to access another\'s social page' do
        sign_in_as @other_user
        get :social, :id => @test_user.id
        assert_response 302
        assert_redirected_to root_path
    end
    
    # UPDATE
    
    test 'should update a user' do
        sign_in_as @test_user
        patch :update, :id => @test_user.id, :authentication => { :password => 'goodpassword' }, :user => { :username => 'newusername' }
        assert_response :found
        @test_user.reload
        assert_equal 'newusername', @test_user.username
    end
    
    test 'should redirect if a user attempts to update another\'s account' do
        sign_in_as @test_user
        patch :update, :id => @other_user.id, :authentication => { :password => 'goodpassword' }, :user => { :email => @test_user.email }
        assert_response 302
        assert_redirected_to root_path
    end
    
    test 'should not permit users to update their own admin status' do
        sign_in_as @test_user
        assert_not @test_user.admin?
        patch :update, :id => @test_user.id, :authentication => { :password => 'goodpassword' }, :user => { :admin => true }
        assert_not @test_user.admin?
    end
end
