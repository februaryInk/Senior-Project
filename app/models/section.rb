class Section < ActiveRecord::Base

    # make the default order of collections of sections dependent on their
    # positions, lowest first.
    default_scope -> { order( :position => :asc ) }
    
    # VIRTUAL ATTRIBUTES
    
    attr_accessor :publish
    
    # VALIDATIONS
    
    validates :content, { :length => { :minimum => 100 }, :on => :update, :if => :publish_now? }

    # ASSOCIATIONS

    belongs_to :manuscript
    has_one :user, :through => :manuscript
    
    # INSTANCE METHODS
    
    # update the word count for the section. this should be used when
    # a section is saved.
    def update_words( content )
    
        downcased_content = content.downcase
        word_count = downcased_content.scan( /[\w-]+/ ).size
        
        self.update_attributes( :content => content, :word_count => word_count )
    end
    
    private
    
        # check if the user wants this section published as well as saved.
        def publish_now?
            self.publish
        end
end
