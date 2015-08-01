class CreateInklingParts < ActiveRecord::Migration
    def change
        create_table :inkling_parts do | t |
        
            t.references :inkling, :foreign_key => true, :index => true
            t.references :inkling_part_guide, :foreign_key => true
            
            t.integer :dark_points
            t.integer :light_points
            t.integer :might_points
            t.integer :total_points
            
            t.string :kind
            t.string :selector

            t.timestamps :null => false
        end
    end
end