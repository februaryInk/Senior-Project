require 'test_helper'

class ConversationTest < ActiveSupport::TestCase
    
    def setup
        @conversation = conversations( :chit_chat )
    end
    
    test 'should be valid' do
        assert @conversation.valid?
    end
    
    # VALIDATIONS
    
    test 'name should be present' do
        @conversation.name = ' ' * 5
        assert_not @conversation.valid?
    end
    
    test 'name should be at most 140 characters' do
        @conversation.name = 'a' * 141
        assert_not @conversation.valid?
    end
end
