class ManuscriptsController < DefaultNamespaceController
    
    # BEFORE ACTIONS
    
    before_action :signed_in_user, :only => [ :create, :new ]
    before_action :correct_user, :only => [ :contents, :destroy, :edit, :show, :update, :write ]
    
    # display the table of contents. AJAX and jQuery are used to make it
    # interactive.
    def contents
        @manuscript_tab = true
        @manuscript = Manuscript.find( params[ :id ] )
        @sections = @manuscript.sections.all
        @section = @manuscript.sections.build
        respond_to do | format |
            format.js
            format.html
        end
    end
    
    # create a manuscript and its inkling.
    def create
        @manuscript = current_user.manuscripts.build( manuscript_params )
        # assign the attributes that the user does not need to specify.
        @manuscript.assign_attributes( :word_count => 0, :might_word_count => 0, :light_word_count => 0, :dark_word_count => 0, :inkling_attributes => { :points => 0, :might_points => 0,  :light_points => 0, :dark_points => 0, :user_id => current_user.id } )
        if @manuscript.save
            @manuscript.generate_inkling
            redirect_to manuscript_path( @manuscript )
        else
            @genres =  %w[ adventure action fantasy historical horror mystery romance paranormal western ]
            render 'new'
        end
    end
    
    # destroy a manuscript.
    def destroy
        manuscript = Manuscript.find( params[ :id ] )
        manuscript.destroy
        redirect_to :back
    end
    
    # display the edit page, where manuscript settings can be updated.
    def edit
        @manuscript_tab = true
        @manuscript = Manuscript.find( params[ :id ] )
        @inkling = @manuscript.inkling
        @genres = %w[ adventure fantasy horror historical mystery romance paranormal ]
    end
    
    # display the feedback page, where all of the feedback for the manuscript is
    # shown.
    def feedback
        @manuscript = Manuscript.find( params[ :id ] )
        @feedback = @manuscript.feedback.paginate( :page => params[ :page ] )
    end

    # display the manuscript library.
    def index
        @updated_manuscripts = Manuscript.limit( 100 ).order( :created_at => :asc ).paginate( :page => params[ :page ] )
    end

    # display the new manuscript page.
    def new
        @manuscript = current_user.manuscripts.build
        @manuscript.build_inkling
        # it may be appropriate to eventually make a genre model, to store typical word count, associated inklings, genre names, genre stamps...
        @genres =  %w[ adventure action fantasy historical horror mystery romance paranormal western ]
    end
    
    # display the manuscript contents in a format for reading.
    def read
        @reader_or_writer = true
        @manuscript = Manuscript.find( params[ :id ] )
        @open_section = params[ :section_id ].nil? ? @manuscript.sections.first : Section.find( params[ :section_id ] )
        @sections = @manuscript.sections.all
        @feedback = Feedback.new
    end

    # display information/statistics relating to the manuscript.
    def show
        @manuscript_tab = true
        @manuscript = Manuscript.find( params[ :id ] )
        @inkling = @manuscript.inkling
        @selectors = @inkling.inkling_parts.map( &:selector ).to_json
    end 
    
    # update manuscript and inkling settings.
    def update
        @manuscript = Manuscript.find( params[ :id ] )
        if @manuscript.update_attributes( manuscript_params )
            redirect_to manuscript_url( @manuscript )
            flash[ :success ] = 'Manuscript settings have been successfully updated.'
        else
            render 'edit'
        end
    end
    
    # display the manuscript contents in a format for reading.
    def write
        @manuscript_tab = true
        @reader_or_writer = true
        @manuscript = Manuscript.find( params[ :id ] )
        @open_section = params[ :section_id ].nil? ? @manuscript.sections.first : Section.find( params[ :section_id ] )
        @sections = @manuscript.sections.all
    end
    
    private
    
        def correct_user
            @manuscript = Manuscript.find( params[ :id ] )
            @user = @manuscript.user
            redirect_to( root_path ) unless current_user?( @user )
        end
    
        def manuscript_params
            params.require( :manuscript ).permit( :description, :genre, :title, :user_id, :inkling_attributes => [:hardcore, :revival_fee, :revival_fee_currency, :word_count_goal, :word_rate_goal, :word_rate_goal_basis] )
        end
end
