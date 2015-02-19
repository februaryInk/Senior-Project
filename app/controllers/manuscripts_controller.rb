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
        # assign the attributes that the user does not need to specify.
        @manuscript.assign_attributes( :word_count => 0, :adventurous_word_count => 0, :romantic_word_count => 0, :scary_word_count => 0, :inkling_attributes => { :points => 0, :adventurous_points => 0,  :romantic_points => 0, :scary_points => 0, :user_id => current_user.id } )
        if @manuscript.save
            inkling = @manuscript.inkling
            standard_parts = BodyPart.find_by( :total_points => 0 )
            inkling.body_parts << standard_parts
            redirect_to manuscript_path( @manuscript )
        else
            render 'new'
        end
    end
    
    def edit
        @manuscript_tab = true
        @manuscript = Manuscript.find( params[ :id ] )
        @genres = %w[ adventure fantasy horror historical mystery romance paranormal ]
    end

    def index
    end

    def new
        @manuscript = current_user.manuscripts.build
        @manuscript.build_inkling
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
            params.require( :manuscript ).permit( :description, :genre, :title, :user_id, :inkling_attributes => [:hardcore, :revival_fee, :revival_fee_currency, :word_count_goal, :word_rate_goal, :word_rate_goal_basis] )
        end
end
