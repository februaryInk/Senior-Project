require 'test_helper'

class ConversationsControllerTest < ActionController::TestCase

    def setup
        @user = users( :test_user )
    end

    test "should get new" do
        sign_in_as @user
        get :new
        assert_response :success
    end

    test "should get show" do
        get :show, :id => 1
        assert_response :success
    end
end
