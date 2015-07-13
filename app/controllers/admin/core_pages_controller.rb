class Admin::CorePagesController < ApplicationController

    include AdminSessionManagement
    
    before_action :signed_in_admin, :only => [ :dashboard ]

    def dashboard
    end
    
    def signed_in_admin
        unless signed_in?
            store_location
            redirect_to admin_signin_url
        end
    end
end
