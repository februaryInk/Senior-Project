require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
    
    test 'layout links' do
        get root_path
        assert_template 'core_pages/home'
        assert_select 'a[href=?]', about_path
        assert_select 'a[href=?]', forums_path
        assert_select 'a[href=?]', help_path
        assert_select 'a[href=?]', root_path
    end
end
