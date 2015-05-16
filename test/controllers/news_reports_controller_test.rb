require 'test_helper'

class NewsReportsControllerTest < ActionController::TestCase
    def setup
        @admin_user = users( :admin_user )
        @news_report = news_reports( :news_report_1 )
    end
    
    test 'should get edit' do
        sign_in_as @admin_user
        get :edit, :id => 1
        assert_response :success
    end
end
