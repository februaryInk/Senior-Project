class FeedbackController < ApplicationController

    layout 'modal.html'
    
    def create
        manuscript = Manuscript.find( params[ :manuscript_id ] )
        feedback = manuscript.feedback.build( feedback_params )
        feedback.assign_attributes( :user_id => current_user.id )
        if feedback.save
            flash[ :success ] = "Your feedback was submitted."
            redirect_to manuscript_read_path( manuscript )
        else
            flash[ :error ] = "Action failed."
            redirect_to manuscript_read_path( manuscript )
        end
    end
    
    def destroy
        feedback = Feedback.find( params[ :id ] )
        feedback.destroy
        redirect_to :back
    end
    
    private
    
        def feedback_params
            params.require( :feedback ).permit( :content )
        end
end
