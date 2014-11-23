class ForumThreadsController < ApplicationController
    layout 'default.html'
    
    def create
        @thread = current_user.forum_threads.build( thread_params )
        if @thread.save
            redirect_to forum_thread_path( @thread.id )
        else
            render new
        end
    end
    
    def edit
    end

    def index
    end

    def new
        @thread = ForumThread.new
    end

    def show
        @thread = ForumThread.find_by( :id => params[ :id ] )
        @posts = @thread.forum_posts.all
        @post = ForumPost.new
    end
    
    private
    
        def thread_params
            params.require( :forum_thread ).permit( :forum_board_id, :name, :content, :user_id )
        end
end
