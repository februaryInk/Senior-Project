require 'test_helper'

class ManuscriptsControllerTest < ActionController::TestCase

    def setup
        @test_user = users( :test_user )
        @other_user = users( :other_user )
        @the_test = manuscripts( :the_test )
        @the_magicians_rival = manuscripts( :the_magicians_rival )
    end
    
    # CONTENTS
    
    test 'should get contents' do
        sign_in_as @test_user
        get :contents, :id => @the_test.id
        assert_template 'manuscripts/contents'
        assert_response :success
    end
    
    test 'should redirect a user who attempts to access someone else\'s contents' do
        sign_in_as @other_user
        get :contents, :id => @the_test.id
        assert_redirected_to root_path
    end
    
    # CREATE
    
    test 'should create a manuscript' do
        sign_in_as @test_user
        inkling_attributes = { :hardcore => false, :revival_fee => 100, :revival_fee_currency => 2, :word_count_goal => 10000, :word_rate_goal => 100, :word_rate_goal_basis => 1 }
        assert_difference 'Manuscript.count', 1 do
            post :create, { :manuscript => { :description => 'A puzzle, so much like a test...', :genre => 'adventure', :rating => 'Candid', :title => 'The Forenzi Puzzle', :user_id => @test_user.id, :inkling_attributes => inkling_attributes } }
        end
    end
    
    test 'should not create a manuscript if no-one is signed in' do
        inkling_attributes = { :hardcore => false, :revival_fee => 100, :revival_fee_currency => 2, :word_count_goal => 10000, :word_rate_goal => 100, :word_rate_goal_basis => 1 }
        assert_difference 'Manuscript.count', 0 do
            post :create, { :manuscript => { :description => 'A puzzle, so much like a test...', :genre => 'adventure', :rating => 'Candid', :title => 'The Forenzi Puzzle', :user_id => @test_user.id, :inkling_attributes => inkling_attributes } }
        end
    end
    
    # DESTROY
    
    test 'should destroy the manuscript' do
        sign_in_as @test_user
        assert_difference 'Manuscript.count', -1 do
            delete :destroy, :id => @the_test.id
        end
        assert_nil Manuscript.find_by( :title => @the_test.title )
    end
    
    test 'should redirect a user who attempts to destroy someone else\'s manuscript' do
        sign_in_as @other_user
        assert_difference 'Manuscript.count', 0 do
          delete :destroy, :id => @the_test.id
        end
        assert_redirected_to root_path
        assert_not_nil Manuscript.find_by( :title => @the_test.title )
    end
    
    # EDIT

    test 'should get edit' do
        sign_in_as @test_user
        get :edit, :id => @the_test.id
        assert_template 'manuscripts/edit'
        assert_response :success
    end
    
    test 'should redirect a user who attempts to access someone else\'s edit' do
        sign_in_as @other_user
        get :edit, :id => @the_test.id
        assert_redirected_to root_path
    end
    
    # FEEDBACK
    
    test 'should get feedback' do
        get :feedback, :id => @the_test.id
        assert_template 'manuscripts/feedback'
        assert_response :success
    end
    
    # INDEX

    test 'should get index' do
        get :index
        assert_template 'manuscripts/index'
        assert_response :success
    end
    
    # NEW

    test 'should get new' do
        sign_in_as @test_user
        get :new
        assert_template 'manuscripts/new'
        assert_response :success
    end
    
    test 'should redirect new if no-one is signed in' do
        get :new
        assert_redirected_to signin_path
    end
    
    # READ
    
    test 'should get read' do
        get :read, :id => @the_test.id
        assert_template 'manuscripts/read'
        assert_response :success
    end
    
    # SHOW

    test 'should get show' do
        sign_in_as @test_user
        get :show, :id => @the_test.id
        assert_template 'manuscripts/show'
        assert_response :success
    end
    
    test 'should redirect a user who attempts to access someone else\'s show' do
        sign_in_as @other_user
        get :show, :id => @the_test.id
        assert_redirected_to root_path
    end
    
    test 'should redirect show if no-one is signed in' do
        get :show, :id => @the_test.id
        assert_redirected_to root_path
    end
    
    # UPDATE
    
    test 'should update the manuscript' do
        sign_in_as @test_user
        patch :update, :id => @the_test.id, :manuscript => { :title => 'The Great Test' }
        assert_response :found
        @the_test.reload
        assert_equal @the_test.title, 'The Great Test'
    end
    
    test 'should redirect a user who attempts to update someone else\'s manuscript' do
        sign_in_as @other_user
        patch :update, :id => @the_test.id, :manuscript => { :title => 'The Rival' }
        assert_redirected_to root_path
        @the_test.reload
        assert_not_equal @the_test_title, 'The Rival'
    end
    
    # WRITE
    
    test 'should get write' do
        sign_in_as @test_user
        get :write, :id => @the_test.id
        assert_template 'manuscripts/write'
        assert_response :success
    end
    
    test 'should redirect a user who attempts to access someone else\'s write' do
        sign_in_as @other_user
        get :write, :id => @the_test.id
        assert_redirected_to root_path
    end
end
