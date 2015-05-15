class SectionsController < ApplicationController
    
    # make a new section with counts initialized to zero at the end of the 
    # manuscript.
    def create
        @manuscript = Manuscript.find( params[ :manuscript_id ] )
        position = @manuscript.sections.count + 1
        default_name = "Chapter #{ position }"
        @section = @manuscript.sections.create( :user_id => current_user.id, :name => default_name, :position => position, :word_count => 0, :dark_word_count => 0, :light_word_count => 0, :might_word_count => 0 )
    end
    
    # destroy the section, then update the positions of the remaining sections and 
    # the manuscript counts. this action is used on the manuscripts content page
    # and uses AJAX.
    def destroy
        section = Section.find( params[ :id ] )
        @manuscript = section.manuscript
        destroyed_position = section.position
        section.destroy
        @sections = @manuscript.sections.all
        @sections.each do | section |
            if section.position > destroyed_position
                section.update_attributes( :position => section.position - 1 )
            end
        end
        @manuscript.update_counts
        @manuscript.inkling.update_points( @manuscript )
        @manuscript.inkling.update_parts
    end
    
    # change the name of a section on blur of the :name field. this action is used 
    # on the manuscripts content page and uses AJAX.
    def rename
        @section = Section.find( params[ :section_id ] )
        @section.update_attributes( :name => params[ :name ] )
        render :nothing => true
    end
    
    # open a new section for editing. this action is used on the manuscripts edit
    # page and uses AJAX.
    def select
        @open_section = Section.find( params[ :data_value ] )
    end
    
    # let the user select which section is displayed and refresh. this action
    # is used on the manuscripts reader page and uses AJAX.
    def select_for_reader    
        @open_section = Section.find( params[ :data_value ] )
        @manuscript = @open_section.manuscript
    end
    
    # let users rearrange the sections in their manuscripts using jQuery-ui's
    # sortable properties. this action is used on the manuscripts contents
    # page and uses AJAX.
    def sort
        positions = JSON.parse( params[ :data_value ] )
        i = 1
        for id in positions
            section = Section.find( id.to_i )
            section.update_attributes( :position => i )
            i += 1
        end
        @manuscript = Section.find( positions[ 1 ].to_i ).manuscript
        @sections = @manuscript.sections.all
    end
    
    # save the section changes, then count key words and update the section and 
    # manuscript counts. this action is used on the manuscripts edit page.
    def update
        @section = Section.find( params[ :id ] )
        @manuscript = @section.manuscript
        inkling = @manuscript.inkling
        
        content = params[ :section ][ :content ]
        @section.update_words( content, might_words, light_words, dark_words )
        
        @manuscript.update_counts
        inkling.update_points( @manuscript )
        inkling.update_parts
        render :nothing => true
    end
    
    private
    
        def might_words
            %w[ arrow compass east north plains river sea snow south sword tree west wild wilderness ]
        end
        
        def light_words
            %w[ beautiful blush breath candle eyes gown handsome light lips love necklace ruffles shine sun sweet ]
        end
    
        def dark_words
            %w[ black blood dark destroy fear fright gore lightening maimed spider storm sweat thunder wolf ]
        end

        def section_params
            params.require( :section ).permit( :manuscript_id, :name )
        end
end
