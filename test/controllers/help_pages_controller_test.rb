require 'test_helper'

class HelpPagesControllerTest < ActionController::TestCase
  test "should get contact_us" do
    get :contact_us
    assert_response :success
  end

  test "should get faq" do
    get :faq
    assert_response :success
  end

  test "should get getting_started" do
    get :getting_started
    assert_response :success
  end

  test "should get help_center" do
    get :help_center
    assert_response :success
  end

end
