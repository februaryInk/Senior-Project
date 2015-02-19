class CreateInklingParts < ActiveRecord::Migration
    def change
        create_table :inklng_parts do | t |
            t.string :selector
            t.string :kind
            t.integer :total_points
            t.integer :adventurous_points
            t.integer :romantic_points
            t.integer :scary_points

            t.timestamps
        end
    end
end
