class ConversationsController < DefaultNamespaceController
    
    # BEFORE ACTIONS
    
    before_action :signed_in_user, :only => [ :destroy, :create, :new ]
    before_action :admin_user, :only => [ :destroy ]
    
    # create a conversation.
    def create
        @conversation = current_user.conversations.build( conversation_params )
        
        if @conversation.save
            redirect_to forum_conversation_path( @conversation.forum.id, @conversation.id )
        else
            render 'new'
        end
    end
    
    # destroy a conversation.
    def destroy
        @conversation = Conversation.find( params[ :id ] )
        @forum = Forum.find( params[ :forum_id ] )
        
        @conversation.destroy
        
        redirect_to forum_path( @forum.id )
    end

    # display the new conversation page.
    def new
        @conversation = current_user.conversations.build
        @conversation.comments.build
        @forums = Forum.all
    end

    # show the conversation with all of its comments.
    def show
        @forum = Forum.find( params[ :forum_id ] )
        @conversation = Conversation.find( params[ :id ] )
        @comments = @conversation.comments.paginate( :page => params[ :page ], :per_page => 15 )
        @comment = Comment.new
    end
    
    private
    
        def conversation_params
            params.require( :conversation ).permit( :forum_id, :name, :comments_attributes => [ :content, :user_id ] )
        end
end
