require 'test_helper'

class SessionsHelperTest < ActionView::TestCase
    
    def setup
        @user = users( :test_user )
        remember( @user )
    end
    
    test 'current_user method returns the correct user when session is nil' do
        assert_equal @user, current_user
        assert is_signed_in?
    end
    
    test 'current_user returns nil if the remember digest is wrong' do
        @user.update_attributes( :remember_digest => User.digest( User.create_token ) )
        assert_nil current_user
    end
end
