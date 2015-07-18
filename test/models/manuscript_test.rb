require 'test_helper'

class ManuscriptTest < ActiveSupport::TestCase
    def setup
        @manuscript = manuscripts( :the_test )
    end
    
    test 'should be valid' do
        assert @manuscript.valid?
    end
    
    # VALIDATIONS
    
    test 'title should be present' do
        @manuscript.title = ' ' * 5
        assert_not @manuscript.valid?
    end
    
    test 'title should be at most 250 characters' do
        @manuscript.title = 'a' * 251
        assert_not @manuscript.valid?
    end
    
    test 'genre should be present' do
        @manuscript.genre = ' ' * 5
        assert_not @manuscript.valid?
    end
    
    test 'genre should be contained in the allowed genres' do
        @manuscript.genre = 'a' * 5
        assert_not @manuscript.valid?
    end
    
    test 'rating should be present' do
        @manuscript.rating = ' ' * 5
        assert_not @manuscript.valid?
    end
    
    test 'rating should be contained in the allowed ratings' do
        @manuscript.rating = 'a' * 5
        assert_not @manuscript.valid?
    end
    
    test 'user_id should be present' do
        @manuscript.user_id = ' '
        assert_not @manuscript.valid?
    end
    
    test 'user_id should be an integer' do
        @manuscript.user_id = 1.75
        assert_not @manuscript.valid?
    end
    
    # INSTANCE METHODS
    
    # skip testing the inkling-related methods until the inkling concept has been 
    # redesigned.
end
