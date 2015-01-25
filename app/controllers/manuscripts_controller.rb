class ManuscriptsController < ApplicationController
    layout 'default.html'
    include AuthorizationFilters
    
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
    
    def create
        @manuscript = current_user.manuscripts.build( manuscript_params )
        # does this, as opposed to initializing these in the form, help prevent meddling with word_counts?
        @manuscript.assign_attributes( :word_count => 0, :adventurous_word_count => 0, :romantic_word_count => 0, :scary_word_count => 0 )
        if @manuscript.save
            redirect_to manuscript_path( @manuscript )
        else
            render 'new'
        end
    end
    
    def edit
        @manuscript_tab = true
        @manuscript = Manuscript.find( params[ :id ] )
        @genres = %w[ adventure fantasy horror mystery romance paranormal ]
    end

    def index
    end

    def new
        @manuscript = current_user.manuscripts.new
        # it may be appropriate to eventually make a genre model, to store typical word count, associated inklings, genre names, genre stamps...
        @genres =  %w[ adventure fantasy horror mystery romance paranormal ]
    end

    def show
        @manuscript_tab = true
        @manuscript = Manuscript.find( params[ :id ] )
    end
    
    def update
        @manuscript = Manuscript.find( params[ :id ] )
        if @manuscript.update_attributes( manuscript_params )
            redirect_to manuscript_url( @manuscript )
        else
            render 'edit'
        end
    end
    
    def write
        @manuscript_tab = true
        @manuscript = Manuscript.find( params[ :id ] )
        @open_section = params[ :section_id ].nil? ? @manuscript.sections.first : Section.find( params[ :section_id ] )
        @sections = @manuscript.sections.all
    end
    
    private
    
        def manuscript_params
            params.require( :manuscript ).permit( :description, :genre, :title, :user_id )
        end
end
