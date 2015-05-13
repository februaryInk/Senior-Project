class ConversationsController < ApplicationController
    layout 'default.html'
    include AuthorizationFilters
    
    before_action :signed_in_user, :only => [ :destroy, :create, :new ]
    
    def create
        @conversation = current_user.conversations.build( conversation_params )
        if @conversation.save
            redirect_to conversation_path( @conversation.id )
        else
            @forums = Forum.all
            render 'new'
        end
    end
    
    def destroy
        @conversation = Conversation.find_by( :id => params[ :id ] )
        @conversation.destroy
        redirect_to forums_path
    end

    def new
        @conversation = current_user.conversations.build
        @conversation.comments.build
        @forums = Forum.all
    end

    def show
        @conversation = Conversation.find_by( :id => params[ :id ] )
        @comments = @conversation.comments.paginate( :page => params[ :page ], :per_page => 15 )
        @comment = Comment.new
    end
    
    private
    
        def conversation_params
            params.require( :conversation ).permit( :forum_id, :name, :user_id, :comments_attributes => [ :content, :conversation, :user_id ] )
        end
end
