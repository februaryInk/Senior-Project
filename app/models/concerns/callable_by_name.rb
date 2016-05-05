module CallableByName

    extend ActiveSupport::Concern
    
    module ClassMethods
    
        def called( name )
        
            self.find_by( :name => name )
        end
    end
end
