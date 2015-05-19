class Post < ActiveRecord::Base

    # RELATIONSHIPS
    
    belongs_to :user
    
    # make the default order of collections of posts dependent on the time they 
    # were created_at, most recent first.
    default_scope -> { order( :created_at => :desc ) }
    
    # VALIDATIONS
    
    validates :content, :presence => true, :length => { :maximum => 1000 }, :reduce => true
end
