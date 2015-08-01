class CreateForums < ActiveRecord::Migration
    def change
        create_table :forums do | t |
        
            t.references :forum_category, :foreign_key => true, :index => true
            
            t.string :name

            t.timestamps :null => false
        end
    end
end
