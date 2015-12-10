require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
    
    def setup
        @test_user = users( :test_user )
    end
    
    test 'user profile display' do
        get user_path( @test_user.id )
        assert_template 'users/show'
        assert_select 'title', users_show_title
        assert_select 'div.member-info__avatar'
        @test_user.activity_feed.paginate( :page => 1 ).each do | post |
            assert_match post.content, response.body
        end
    end
end
