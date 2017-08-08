class FaqCategory < ApplicationRecord
    
    include CallableByName
    
    # ASSOCIATIONS
    
    has_many( :faqs )
end
