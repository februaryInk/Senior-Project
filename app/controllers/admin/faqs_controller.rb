class Admin::FaqsController < AdminNamespaceController
    
    # BEFORE ACTIONS
    
    before_action :signed_in_admin
    
    # create a question and answer.
    def create
        @faq = Faq.new( faq_params )
        if @faq.save
            flash[ :success ] = 'Frequently Asked Question successfully created.'
            redirect_to( admin_faqs_path )
        else
            render( 'new.html.haml' )
        end
    end
    
    # destroy a question and answer.
    def destroy
        faq = Faq.find( params[ :id ] )
        faq.destroy
        flash[ :success ] = 'Frequently Asked Question successfully destroyed.'
        redirect_to( admin_faqs_path )
    end
    
    # display a question and answer's edit page.
    def edit
        @faq = Faq.find( params[ :id ] )
    end
    
    # display a list of all questions and answers.
    def index
        @faqs = Faq.all
    end
    
    # display the question and answer creation form.
    def new
        @faq = Faq.new
    end
    
    # display the question and answer.
    def show
        @faq = Faq.find( params[ :id ] )
    end
    
    # update a question and answer.
    def update
        @faq = Faq.find( params[ :id ] )
        if @faq.update_attributes( faq_params )
            flash[ :success ] = 'Frequently Asked Question has been updated.'
            redirect_to( admin_faqs_path )
        else
            render( 'edit.html.haml' )
        end
    end
    
    private
        
        def faq_params
            params.require( :faq ).permit( 
                :answer,
                :position,
                :question,
                :faq_category_id
            )
        end
end
