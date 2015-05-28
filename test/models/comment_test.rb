require 'test_helper'

class CommentTest < ActiveSupport::TestCase
    
    def setup
        @comment_1 = comments( :comment_1 )
    end
    
    test 'should be valid' do
        assert @comment_1.valid?
    end
    
    # VALIDATIONS
    
    test 'user_id should be present' do
        @comment_1.user_id = ' '
        assert_not @comment_1.valid?
    end
    
    test 'conversation should be present' do
        @comment_1.conversation_id = ' '
        assert_not @comment_1.valid?
    end
    
    test 'content should be present' do
        @comment_1.content = ' '
        assert_not @comment_1.valid?
    end
end
