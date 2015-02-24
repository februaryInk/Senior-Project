class CreateInklingParts < ActiveRecord::Migration
    def change
        create_table :inkling_parts do | t |
            t.references :inkling
            t.references :inkling_part_guide
            t.string :selector
            t.string :kind
            t.integer :total_points
            t.integer :might_points
            t.integer :light_points
            t.integer :dark_points

            t.timestamps
        end
    end
end