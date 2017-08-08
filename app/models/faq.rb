class Faq < ApplicationRecord
    
    # ASSOCIATIONS
    
    belongs_to( :faq_category )
end
