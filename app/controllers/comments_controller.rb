class CommentsController < ApplicationController
    include AuthorizationFilters

    before_action :signed_in_user, :only => [ :destroy, :create ]
    before_action :current_conversation, :only => [ :create ]

    def create
        @comment = current_user.comments.build( comment_params )
        if @comment.save
            redirect_to conversation_url( current_conversation.id )
        else
            redirect_to conversation_url( current_conversation.id ), :flash => { :comment_errors => @comment.errors.full_messages }
        end
    end
    
    def destroy
    end
    
    private
    
        def current_conversation
            Conversation.find_by( id: params[ :comment ][ :conversation_id ] )
        end
        
        def comment_params
            params.require( :comment ).permit( :content, :conversation_id, :user_id )
        end
end
