require 'test_helper'

class HelpPagesControllerTest < ActionController::TestCase

    test 'should get contact' do
        get :contact
        assert_response :success
        assert_select 'title', contact_title
    end

    test 'should get faq' do
        get :faq
        assert_response :success
        assert_select 'title', faq_title
    end

    test 'should get getting_started' do
        get :getting_started
        assert_response :success
        assert_select 'title', getting_started_title
    end

    test 'should get help_center' do
        get :help_center
        assert_response :success
        assert_select 'title', help_title
    end
end
