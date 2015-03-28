class ManuscriptsController < ApplicationController
    layout 'default.html'
    include AuthorizationFilters
    
    before_action :signed_in_user, :only => [ :create, :new ]
    before_action :correct_user, :only => [ :contents, :destroy, :edit, :show, :update, :write ]
    
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
        @manuscript.assign_attributes( :word_count => 0, :might_word_count => 0, :light_word_count => 0, :dark_word_count => 0, :inkling_attributes => { :points => 0, :might_points => 0,  :light_points => 0, :dark_points => 0, :user_id => current_user.id } )
        if @manuscript.save
            @manuscript.generate_inkling
            redirect_to manuscript_path( @manuscript )
        else
            @genres =  %w[ adventure action fantasy historical horror mystery romance paranormal western ]
            render 'new'
        end
    end
    
    def destroy
        manuscript = Manuscript.find( params[ :id ] )
        manuscript.destroy
        redirect_to :back
    end
    
    def edit
        @manuscript_tab = true
        @manuscript = Manuscript.find( params[ :id ] )
        @inkling = @manuscript.inkling
        @genres = %w[ adventure fantasy horror historical mystery romance paranormal ]
    end

    def index
    end

    def new
        @manuscript = current_user.manuscripts.build
        @manuscript.build_inkling
        # it may be appropriate to eventually make a genre model, to store typical word count, associated inklings, genre names, genre stamps...
        @genres =  %w[ adventure action fantasy historical horror mystery romance paranormal western ]
    end

    def show
        @manuscript_tab = true
        @manuscript = Manuscript.find( params[ :id ] )
        @inkling = @manuscript.inkling
        @selectors = @inkling.inkling_parts.map( &:selector ).to_json
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
    
        def correct_user
            @manuscript = Manuscript.find( params[ :id ] )
            @user = @manuscript.user
            redirect_to( root_path ) unless current_user?( @user )
        end
    
        def manuscript_params
            params.require( :manuscript ).permit( :description, :genre, :title, :user_id, :inkling_attributes => [:hardcore, :revival_fee, :revival_fee_currency, :word_count_goal, :word_rate_goal, :word_rate_goal_basis] )
        end
end
