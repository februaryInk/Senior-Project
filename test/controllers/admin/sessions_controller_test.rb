require 'test_helper'

class Admin::SessionsControllerTest < ActionController::TestCase
    def setup
        @admin_user = users( :admin_user )
        @test_user = users( :test_user )
        @unactivated_user = users( :absent_user )
    end

    # CREATE

    test 'should sign in a user with the correct email and password' do
        assert_nil session[ :user_id ]
        post :create, :session => { :email => @admin_user.email, :password => 'goodpassword' }
        assert_equal session[ :admin_user_id ], @admin_user.id
        assert_redirected_to admin_root_path
    end
    
    test 'should not sign in a user that is not an admin' do
        assert_nil session[ :admin_user_id ]
        post :create, :session => { :email => @test_user.email, :password => 'goodpassword' }
        assert_nil session[ :admin_user_id ]
        assert_template 'admin/sessions/new'
        assert_not_nil flash[ :session_error ]
    end
    
    test 'should not sign in a user with an incorrect password' do
        assert_nil session[ :admin_user_id ]
        post :create, :session => { :email => @admin_user.email, :password => 'wrongpassword' }
        assert_nil session[ :admin_user_id ]
        assert_template 'admin/sessions/new'
        assert_not_nil flash[ :session_error ]
    end
    
    # DESTROY
    
    test 'should sign out a user' do
        sign_in_as_admin @admin_user
        assert admin_is_signed_in?
        delete :destroy, :id => @admin_user.id
        assert_not admin_is_signed_in?
    end

    # NEW
    
    test 'should get new' do
        get :new
        assert_response :success
        assert_template 'admin/sessions/new'
        assert_select 'title', admin_signin_title 
    end
end
