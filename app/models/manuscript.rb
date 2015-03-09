class Manuscript < ActiveRecord::Base
    belongs_to :user
    
    has_one :inkling, :inverse_of => :manuscript, :dependent => :destroy
    accepts_nested_attributes_for :inkling
    
    has_many :sections, :dependent => :destroy
    
    validates :title, :presence => true, :length => { :maximum => 250 }
    validates :genre, :presence => true, :inclusion => { :in => %w[ adventure action fantasy historical horror mystery romance paranormal western ] }, :reduce => true
    validates :user_id, :presence => true, :numericality => { :only_integer => true }, :reduce => true
end
