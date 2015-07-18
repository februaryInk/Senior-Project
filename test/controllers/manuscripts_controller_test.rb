require 'test_helper'

class ManuscriptsControllerTest < ActionController::TestCase

    def setup
        @user = users( :test_user )
        @the_test = manuscripts( :the_test )
    end

    test "should get edit" do
        sign_in_as @user
        get :edit, :id => @the_test.id
        assert_response :success
    end

    test "should get index" do
        get :index
        assert_response :success
    end

    test "should get new" do
        sign_in_as @user
        get :new
        assert_response :success
    end

    test "should get show" do
        sign_in_as @user
        get :show, :id => @the_test.id
        assert_response :success
    end
end
