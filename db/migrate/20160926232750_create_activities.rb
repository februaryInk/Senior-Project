class CreateActivities < ActiveRecord::Migration
    def change
        create_table( :activities ) do | t |
          
            t.references :manuscript, :foreign_key => true, :index => true
            t.references :user, :foreign_key => true, :index => true
            
            t.integer :words

            t.timestamps :null => false
        end
    end
end
