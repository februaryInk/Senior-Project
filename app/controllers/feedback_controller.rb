class FeedbackController < DefaultNamespaceController

    layout 'simple'
    
    include AuthorizationFilters
    
    before_action :signed_in_user, :only => [ :create, :destroy ]
    
    # create feedback.
    def create
        manuscript = Manuscript.find( params[ :manuscript_id ] )
        feedback = manuscript.feedback.build( feedback_params )
        feedback.assign_attributes( :user_id => current_user.id )
        
        respond_to do | format |
            if feedback.save
                format.json do
                    flash[ :success ] = "Thank you! Your feedback was submitted."
                    render( { json: nil, status: 200 } )
                end
            else
                format.json { render( { json: feedback.errors.messages, status: 400 } ) }
            end
        end
    end
    
    # destroy feedback.
    def destroy
        feedback = Feedback.find( params[ :id ] )
        feedback.destroy
        redirect_to read_manuscript_path( params[ :manuscript_id ] )
    end
    
    private
    
        def feedback_params
            params.require( :feedback ).permit( :content )
        end
end
