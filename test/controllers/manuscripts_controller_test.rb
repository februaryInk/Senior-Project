require 'test_helper'

class ManuscriptsControllerTest < ActionController::TestCase

    def setup
        @user = users( :test_user )
        @inkling = inklings( :inkling_1 )
    end

    test "should get edit" do
        sign_in_as @user
        get :edit, :id => 1
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
        get :show, :id => 1
        assert_response :success
    end
end
