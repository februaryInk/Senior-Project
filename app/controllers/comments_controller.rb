class CommentsController < ApplicationController

    include AuthorizationFilters

    # BEFORE ACTIONS
    
    before_action :signed_in_user, :only => [ :destroy, :create ]

    # create a comment. this action uses AJAX.
    def create
        @comment = current_user.comments.build( comment_params )
        @conversation = current_conversation
        respond_to do | format |
            if @comment.save
                @saved = true
                format.html { redirect_to conversation_path( @conversation.id ) }
            else
                @saved = false
            end
            format.js { render layout: false, content_type: 'text/javascript' }
        end
    end
    
    private
    
        # get the conversation to which the comment belongs.
        def current_conversation
            Conversation.find_by( id: params[ :comment ][ :conversation_id ] )
        end
        
        def comment_params
            params.require( :comment ).permit( :content, :conversation_id, :user_id ) 
        end
end
