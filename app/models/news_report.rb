class NewsReport < ActiveRecord::Base
    belongs_to :user
    
    default_scope -> { order( :created_at => :desc ) }
    
    validates :content, :presence => true
    validates :title, :length => { :maximum => 140 }, :presence => true
end
