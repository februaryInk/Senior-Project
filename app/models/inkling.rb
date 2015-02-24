class Inkling < ActiveRecord::Base
    belongs_to :user
    belongs_to :manuscript
    
    has_many :inkling_parts
    
    validates :revival_fee, :presence => true, :numericality => { :only_integer => true }
    validates :revival_fee_currency, :presence => true
    validates :word_count_goal, :presence => true, :numericality => { :only_integer => true }
    validates :word_rate_goal, :presence => true, :numericality => { :only_integer => true }
    validates :word_rate_goal_basis, :presence => true, :numericality => { :only_integer => true }
end
