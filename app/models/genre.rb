class Genre < ActiveRecord::Base

    # it may be appropriate to eventually expand the genre model, to store typical word 
    # count, associated inklings, genre names, genre stamps...
    
    include CalledClassMethod
    
    # VALIDATIONS
    
    # validates_associated :manuscripts

    # RELATIONSHIPS
    
    has_many :genre_manuscripts
    has_many :manuscripts, :through => :genre_manuscripts
end
