class PostsController < ApplicationController

    include AuthorizationFilters
    
    # BEFORE ACTIONS
    
    before_action :signed_in_user, :only => [ :create, :destroy ]
    before_action :owner_user, :only => [ :destroy ]
    
    # create a post. this action uses AJAX.
    def create
        @post = current_user.posts.build( post_params )
        respond_to do | format |
            if @post.save
                @saved = true
                format.html { redirect_to user_path( current_user.id ) }
            else
                @saved = false
            end
            format.js { render layout: false, content_type: 'text/javascript' }
        end
    end
    
    # destroy a post.
    def destroy
        @post = Post.find( params[ :id ] )
        @post.destroy
        redirect_to user_path( current_user.id )
    end

    private
    
        # redirect unless the current_user owns the post.
        def owner_user
            owner = Post.find( params[ :id ] ).user
            redirect_to root_path unless current_user?( owner )
        end
    
        def post_params
            params.require( :post ).permit( :content )
        end
end