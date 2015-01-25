class Section < ActiveRecord::Base
    belongs_to :manuscript
    belongs_to :user
    
    default_scope -> { order( :position => :asc ) }
end
