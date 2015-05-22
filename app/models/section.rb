class Section < ActiveRecord::Base

    # make the default order of collections of sections dependent on their
    # positions, lowest first.
    default_scope -> { order( :position => :asc ) }

    # RELATIONSHIPS

    belongs_to :manuscript
    belongs_to :user
    
    # INSTANCE METHODS
    
    # update the word and keyword counts for the section. this should be used when
    # a section is saved.
    def update_words( content, might_words, light_words, dark_words )
        might_word_count = 0
        light_word_count = 0
        dark_word_count = 0
        
        downcased_content = content.downcase
        word_count = downcased_content.scan( /[\w-]+/ ).size
        
        might_words.each do | word |
            might_word_count += downcased_content.scan( word ).size
        end
        light_words.each do | word |
            light_word_count += downcased_content.scan( word ).size
        end
        dark_words.each do | word |
            dark_word_count += downcased_content.scan( word ).size
        end
        
        self.update_attributes( :might_word_count => might_word_count, :content => content, :light_word_count => light_word_count, :dark_word_count => dark_word_count, :word_count => word_count )
    end
end
