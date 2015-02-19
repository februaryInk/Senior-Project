class Manuscript < ActiveRecord::Base
    belongs_to :user
    
    has_one :inkling, :inverse_of => :manuscript, :dependent => :destroy
    accepts_nested_attributes_for :inkling
    
    has_many :sections, :dependent => :destroy
    
    validates :title, :presence => true, :length => { :maximum => 250 }
    validates :user_id, :presence => true
end
