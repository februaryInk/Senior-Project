class ConversationsController < ApplicationController
    layout 'default.html'
    
    def create
        @conversation = current_user.conversations.build( conversation_params )
        if @conversation.save
            redirect_to conversation_path( @conversation.id )
        else
            render new
        end
    end
    
    def edit
    end

    def index
    end

    def new
        @conversation = Conversation.new
    end

    def show
        @conversation = Conversation.find_by( :id => params[ :id ] )
        @comments = @conversation.comments.all
        @comment = Comment.new
    end
    
    private
    
        def conversation_params
            params.require( :conversation ).permit( :content, :forum_id, :name, :user_id )
        end
end
