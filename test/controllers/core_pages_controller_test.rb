require 'test_helper'

class CorePagesControllerTest < ActionController::TestCase

    # ABOUT

    test 'should get about' do
        get :about
        assert_response :success
        assert_template 'core_pages/about'
        assert_select 'title', about_title
    end
    
    # HOME

    test 'should get home' do
        get :home
        assert_response :success
        assert_template 'core_pages/home'
        assert_select 'title', home_title
    end
end
