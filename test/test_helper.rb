ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  
    fixtures :all # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    
    include ApplicationHelper
    include CorePagesHelper
    include HelpPagesHelper
    include SessionsHelper
    include UsersHelper
end
