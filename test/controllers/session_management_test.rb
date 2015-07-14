require 'test_helper'

class SessionManagementTest < ActionController::TestCase

    include SessionManagement

    def setup
        @test_user = users( :test_user )
        remember( @test_user )
    end
    
    test 'current_user method returns the correct user when session is nil' do
        assert_equal @test_user, current_user
        assert is_signed_in?
    end
    
    test 'current_user returns nil if the remember digest is wrong' do
        @test_user.update_attributes( :remember_digest => User.digest( User.create_token ) )
        assert_nil current_user
    end
end
