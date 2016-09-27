class Activity < ActiveRecord::Base
    
    # ASSOCIATIONS
    
    belongs_to :manuscript
    belongs_to :user
end
