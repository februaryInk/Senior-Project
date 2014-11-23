class ForumPostsController < ApplicationController

    before_action :current_thread, :only => [ :create ]

    def create
        @post = current_user.forum_posts.build( post_params )
        if @post.save
            redirect_to forum_thread_url( current_thread.id )
        end
    end
    
    def destroy
    end
    
    private
    
        def current_thread
            @current_thread = ForumThread.find_by( id: params[ :forum_post ][ :forum_thread_id ] )
        end
        
        def post_params
            params.require( :forum_post ).permit( :content, :forum_thread_id, :user_id )
        end
end
