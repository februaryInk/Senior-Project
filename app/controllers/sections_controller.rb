class SectionsController < ApplicationController
    
    def create
        # make a new section with counts initialized to zero at the end of the stack.
        @manuscript = Manuscript.find( params[ :manuscript_id ] )
        position = @manuscript.sections.count + 1
        name = "Chapter #{ position }"
        @section = @manuscript.sections.build( :user_id => current_user.id, :name => name, :position => position, :word_count => 0, :scary_word_count => 0, :romantic_word_count => 0, :adventurous_word_count => 0 )
        @section.save
    end
    
    def destroy
        # destroy the section and update the manuscript counts.
        @section = Section.find( params[ :id ] )
        destroyed_position = @section.position
        @section.destroy
        @sections = @section.manuscript.sections.all
        @sections.each do | section |
            if section.position > destroyed_position
                section.update_attributes( :position => section.position - 1 )
            end
        end
    end
    
    def rename
        @section = Section.find( params[ :section_id ] )
        @section.update_attributes( :name => params[ :name ] )
        render :nothing => true
    end
    
    def select
        @open_section = Section.find( params[ :data_value ] )
    end
    
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
    
    def update
        # save the section changes, then count key words and update the section and manuscript counts.
        @section = Section.find( params[ :id ] )
        @manuscript = @section.manuscript
        adventurous_word_count = 0
        romantic_word_count = 0
        scary_word_count = 0
        content = params[ :section ][ :content ]
        downcased_content = content.downcase
        word_count = downcased_content.scan(/[\w-]+/).size
        adventurous_words.each do | word |
            adventurous_word_count += downcased_content.scan( word ).size
        end
        romantic_words.each do | word |
            romantic_word_count += downcased_content.scan( word ).size
        end
        scary_words.each do | word |
            scary_word_count += downcased_content.scan( word ).size
        end
        @section.update_attributes( :adventurous_word_count => adventurous_word_count, :content => content, :romantic_word_count => romantic_word_count, :scary_word_count => scary_word_count, :word_count => word_count )
        update_manuscript_counts( @manuscript )
        render :nothing => true
    end
    
    private
    
        def adventurous_words
            %w[ arrow compass east north plains river sea snow south sword tree west wild wilderness ]
        end
        
        def romantic_words
            %w[ beautiful blush breath candle eyes gown handsome light lips love necklace ruffles sweet ]
        end
    
        def scary_words
            %w[ black blood dark destroy fear fright gore lightening maimed spider storm sweat thunder wolf ]
        end

        def section_params
            params.require( :section ).permit( :manuscript_id, :name )
        end
        
        def update_manuscript_counts( manuscript )
            adventurous_word_count = 0
            romantic_word_count = 0
            scary_word_count = 0
            word_count = 0
            manuscript.sections.each do | section |
                adventurous_word_count += section.adventurous_word_count
                romantic_word_count += section.romantic_word_count
                scary_word_count += section.scary_word_count
                word_count += section.word_count
            end
            manuscript.update_attributes( :adventurous_word_count => adventurous_word_count, :romantic_word_count => romantic_word_count, :scary_word_count => scary_word_count, :word_count => word_count )
        end
end
