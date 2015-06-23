class NewsReport < ActiveRecord::Base

    # make the default order of collections of news_reports dependent on the
    # time they were created_at, most recent first.
    default_scope -> { order( :created_at => :desc ) }
    
    # VALIDATIONS
    
    validates :title, :presence => true, :length => { :maximum => 140 }
    validates :content, :presence => true
    validates :user_id, :presence => true
    
    # RELATIONSHIPS

    belongs_to :user
end
