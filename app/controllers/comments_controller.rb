class CommentsController < DefaultNamespaceController

    # BEFORE ACTIONS
    
    before_action :signed_in_user, :only => [ :destroy, :create ]

    # create a comment. this action uses AJAX.
    def create
        @forum = Forum.find( params[ :forum_id ] )
        @conversation = Conversation.find( params[ :conversation_id ] )
        @comment = current_user.comments.build( comment_params.merge( :conversation_id => @conversation.id ) )
        @comment.save
        
        respond_to do | format |
            format.js {  }
        end
    end
    
    private
        
        def comment_params
            params.require( :comment ).permit( :content, :user_id )
        end
end
