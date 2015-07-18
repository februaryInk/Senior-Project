require 'test_helper'

class PostTest < ActiveSupport::TestCase
    
    def setup
        @test_user = users( :test_user )
        @post = posts( :post_1 )
    end
    
    test 'should be valid' do
        assert @post.valid?
    end
    
    test 'user_id must be present' do
        @post.user_id = nil
        assert_not @post.valid?
    end
    
    test 'content must be present' do
        @post.content = ''
        assert_not @post.valid?
    end
    
    test 'content must not be more than 1000 characters' do
        @post.content = 'a' * 1001
        assert_not @post.valid?
    end
    
    test 'default restrieval order should be most recent first' do
        assert_equal posts( :post_3 ), Post.first
    end
    
    test 'a user\'s posts should be deleted with their account' do
        assert_difference 'Post.count', @test_user.posts.count * -1 do
            @test_user.destroy
        end
    end
end
