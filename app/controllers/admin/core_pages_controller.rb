class Admin::CorePagesController < AdminNamespaceController
    
    before_action :signed_in_admin

    def dashboard
    end
end
