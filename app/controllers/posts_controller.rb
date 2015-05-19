class PostsController < ApplicationController

    include AuthorizationFilters
    
    before_action :signed_in_user, :only => [ :create, :destroy ]
    before_action :owner_user, :only => [ :destroy ]
    
    def create
        @post = Post.new( post_params )
        respond_to do | format |
            if @post.save
                @saved = true
                format.html { redirect_to user_path( params[ :user_id ] ) }
            else
                @saved = false
            end
            format.js { render layout: false, content_type: 'text/javascript' }
        end
    end
    
    def destroy
        @post = Post.find( params[ :id ] )
        @post.destroy
        redirect_to user_path( params[ :user_id ] )
    end

    private
    
        def owner_user
            owner = User.find( params[ :user_id ] )
            redirect_to root_path unless current_user?( owner )
        end
    
        def post_params
            params.require( :post ).permit( :content ).merge( params.permit( :user_id ) )
        end
end
