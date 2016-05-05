class FaqCategory < ActiveRecord::Base
    
    include CallableByName
    
    # ASSOCIATIONS
    
    has_many( :faqs )
end
