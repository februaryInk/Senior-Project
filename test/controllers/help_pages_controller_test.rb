require 'test_helper'

class HelpPagesControllerTest < ActionController::TestCase

    # CONTACT

    test 'should get contact' do
        get :contact
        assert_response :success
        assert_template 'help_pages/contact'
        assert_select 'title', contact_title
    end
    
    # FAQ

    test 'should get faq' do
        get :faq
        assert_response :success
        assert_template 'help_pages/faq'
        assert_select 'title', faq_title
    end
    
    # GETTING STARTRED

    test 'should get getting_started' do
        get :getting_started
        assert_response :success
        assert_template 'help_pages/getting_started'
        assert_select 'title', getting_started_title
    end
    
    # HELP CENTER

    test 'should get help_center' do
        get :help_center
        assert_response :success
        assert_template 'help_pages/help_center'
        assert_select 'title', help_title
    end
end
