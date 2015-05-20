class NewsReport < ActiveRecord::Base

    # RELATIONSHIPS

    belongs_to :user
    
    # make the default order of collections of news_reports dependent on the
    # time they were created_at, most recent first.
    default_scope -> { order( :created_at => :desc ) }
    
    # VALIDATIONS
    
    validates :title, :length => { :maximum => 140 }, :presence => true
    validates :content, :presence => true
    validates :user_id, :presence => true
end
