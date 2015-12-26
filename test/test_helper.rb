ENV[ 'RAILS_ENV' ] ||= 'test'

require 'simplecov'; SimpleCov.start
require File.expand_path( '../../config/environment', __FILE__ )
require 'rails/test_help'
require 'win32console'

class ActiveSupport::TestCase
    # setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all
    
    include ApplicationHelper
    
    include Admin::CorePagesHelper
    include Admin::SessionsHelper
    
    include ConversationsHelper
    include CorePagesHelper
    include ForumsHelper
    include HelpPagesHelper
    include ManuscriptsHelper
    include PasswordResetsHelper
    include SessionsHelper
    include UsersHelper
    
    def admin_is_signed_in?
        !session[ :admin_user_id ].nil?
    end
    
    def is_signed_in?
        !session[ :user_id ].nil?
    end
    
    def sign_in_as( user, options = {  } )
        password = options[ :password ] || 'goodpassword'
        remember_me = options[ :remember_me ] || '1'
        if integration_test?
            post signin_path, :session => { :email => user.email, :password => password, :remember_me => remember_me }
        else
            session[ :user_id ] = user.id
        end
    end
    
    def sign_in_as_admin( admin_user, options = {  } )
        password = options[ :password ] || 'goodpassword'
        if integration_test?
            post admin_signin_path, :session => { :email => admin_user.email, :password => password }
        else
            session[ :admin_user_id ] = admin_user.id
        end
    end
    
    private
        
        def integration_test?
            defined?( post_via_redirect )
        end
end
