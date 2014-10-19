require 'test_helper'

class CorePagesControllerTest < ActionController::TestCase

  test 'should get about' do
    get :about
    assert_response :success
    assert_select 'title', about_title
  end

  test 'should get home' do
    get :home
    assert_response :success
    assert_select 'title', home_title
  end
end
