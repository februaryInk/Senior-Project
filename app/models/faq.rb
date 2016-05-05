class Faq < ActiveRecord::Base
    
    # ASSOCIATIONS
    
    belongs_to( :faq_category )
end
