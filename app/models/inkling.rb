class Inkling < ActiveRecord::Base

    # CLASS CONSTANTS
    
    CURRENCIES = [ 'Points', 'Words' ]
    
    # VALIDATIONS
    
    validates :word_count_goal, :presence => true, :numericality => { :only_integer => true }, :reduce => true
    validates :word_rate_goal, :presence => true, :numericality => { :only_integer => true }, :reduce => true
    validates :word_rate_goal_basis, :presence => true, :numericality => { :only_integer => true }, :reduce => true
    validates :revival_fee, :presence => true, :numericality => { :only_integer => true }, :reduce => true
    validates :revival_fee_currency, :presence => true, :inclusion => { :in => CURRENCIES }, :reduce => true
    
    # RELATIONSHIPS

    belongs_to :manuscript
    
    has_one :user, :through => :manuscript
end
