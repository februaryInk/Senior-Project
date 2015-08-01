class Rating < ActiveRecord::Base
    
    # RELATIONSHIPS
    
    has_many :manuscripts
    
    # CLASS METHODS
    
    def Rating.called( name )
        Rating.find_by( name: name )
    end
end
