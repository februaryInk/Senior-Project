class AdminNamespaceController < ApplicationController

    layout( 'admin.html.haml' )
    
    include AdminSessionManagement

    def signed_in_admin
        unless signed_in?
            store_location
            redirect_to admin_signin_url
        end
    end
end