require 'test_helper'

class Admin::CorePagesControllerTest < ActionController::TestCase

    def setup
        @admin_user = users( :admin_user )
    end

    test "should get dashboard" do
        sign_in_as_admin( @admin_user )
        get :dashboard
        assert_response :success
    end
end
