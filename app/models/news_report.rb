class NewsReport < ActiveRecord::Base
    
    # VALIDATIONS
    
    validates :title, :presence => true, :length => { :maximum => 140 }
    validates :content, :presence => true
    validates :user_id, :presence => true
    
    # RELATIONSHIPS

    belongs_to :user
end
