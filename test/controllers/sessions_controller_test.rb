require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

    def setup
        @test_user = users( :test_user )
        @unactivated_user = users( :absent_user )
        @unremembered_user = users( :friendly_user )
    end

    # CREATE

    test 'should sign in a user with the correct email and password' do
        assert_nil session[ :user_id ]
        post :create, :session => { :email => @test_user.email, :password => 'goodpassword' }
        assert_equal session[ :user_id ], @test_user.id
        assert_redirected_to user_path( @test_user.id )
    end
    
    test 'should remember a user who checked the remember_me box' do
        assert_nil session[ :user_id ]
        post :create, :session => { :email => @unremembered_user.email, :password => 'goodpassword', :remember_me => 1 }
        @unremembered_user.reload
        assert_equal session[ :user_id ], @unremembered_user.id
        assert_not_nil @unremembered_user.remember_digest
        assert_not_nil cookies[ :remember_token ]
        assert_redirected_to user_path( @unremembered_user.id )
    end
    
    test 'should not sign in a user that is not activated' do
        assert_nil session[ :user_id ]
        post :create, :session => { :email => @unactivated_user.email, :password => 'goodpassword' }
        assert_nil session[ :user_id ]
        assert_redirected_to root_path
        assert_not_nil flash[ :warning ]
    end
    
    test 'should not sign in a user with an incorrect password' do
        assert_nil session[ :user_id ]
        post :create, :session => { :email => @test_user.email, :password => 'wrongpassword' }
        assert_nil session[ :user_id ]
        assert_template 'sessions/new'
        assert_select 'p.t--danger'
    end
    
    # DESTROY
    
    test 'should sign out a user' do
        sign_in_as @test_user
        assert is_signed_in?
        delete :destroy, :id => @test_user.id
        assert_not is_signed_in?
    end

    # NEW
    
    test 'should get new' do
        get :new
        assert_response :success
        assert_template 'sessions/new'
        assert_select 'title', signin_title 
    end
end
