require 'test_helper'

class NewsReportTest < ActiveSupport::TestCase
    
    def setup
        @news_report_1 = news_reports( :news_report_1 )
    end
    
    test 'should be valid' do
        assert @news_report_1.valid?
    end
    
    # VALIDATIONS
    
    test 'title should be present' do
        @news_report_1.title = ' ' * 5
        assert_not @news_report_1.valid?
    end
    
    test 'title should be at most 140 characters' do
        @news_report_1.title = 'a' * 141
        assert_not @news_report_1.valid?
    end
    
    test 'content should be present' do
        @news_report_1.content = ' ' * 5
        assert_not @news_report_1.valid?
    end
    
    test 'user_id should be present' do
        @news_report_1.user_id = ''
        assert_not @news_report_1.valid?
    end
end
