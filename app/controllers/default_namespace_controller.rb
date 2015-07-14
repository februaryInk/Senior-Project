class DefaultNamespaceController < ApplicationController

    layout 'default'
    
    include AuthorizationFilters
    include SessionManagement
    
    helper SessionManagementHelper
end