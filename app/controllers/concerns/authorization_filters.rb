module AuthorizationFilters
    
    extend ActiveSupport::Concern
    
    private
        
        def admin_user
            redirect_to user_url( current_user ) unless current_user.admin?
        end
    
        def correct_user
            @user = User.find( params[ :id ] )
            redirect_to( root_url ) unless current_user?( @user )
        end
    
        def signed_in_user
            unless signed_in?
                store_location
                redirect_to signin_url
            end
        end
end
