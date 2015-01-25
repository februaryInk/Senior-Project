class Manuscript < ActiveRecord::Base
    belongs_to :user
    
    has_many :sections, :dependent => :destroy
    
    validates :title, :presence => true, :length => { :maximum => 250 }
    validates :user_id, :presence => true
end
