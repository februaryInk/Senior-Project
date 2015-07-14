class Admin::CorePagesController < AdminNamespaceController
    
    before_action :signed_in_admin

    def dashboard
    end
    
    def signed_in_admin
        unless signed_in?
            store_location
            redirect_to admin_signin_url
        end
    end
end
