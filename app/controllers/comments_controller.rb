class CommentsController < DefaultNamespaceController

    # BEFORE ACTIONS
    
    before_action :signed_in_user, :only => [ :destroy, :create ]

    # create a comment. this action uses AJAX.
    def create
        @forum = Forum.find( params[ :forum_id ] )
        @conversation = Conversation.find( params[ :conversation_id ] )
        @comment = current_user.comments.build( comment_params.merge( :conversation_id => @conversation.id ) )
        
        respond_to do | format |
            if @comment.save
                @saved = true
                format.html { redirect_to forum_conversation_path( @forum, @conversation.id ) }
            else
                @saved = false
            end
            format.js { render layout: false, content_type: 'text/javascript' }
        end
    end
    
    private
        
        def comment_params
            params.require( :comment ).permit( :content, :user_id )
        end
end
