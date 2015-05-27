require 'test_helper'

class ConversationTest < ActiveSupport::TestCase
    
    def setup
        @conversation_1 = conversations( :conversation_1 )
    end
    
    test 'should be valid' do
        assert @conversation_1.valid?
    end
    
    # VALIDATIONS
    
    test 'name should be present' do
        @conversation_1.name = ' ' * 5
        assert_not @conversation_1.valid?
    end
    
    test 'name should be at most 140 characters' do
        @conversation_1.name = 'a' * 141
        assert_not @conversation_1.valid?
    end
end
