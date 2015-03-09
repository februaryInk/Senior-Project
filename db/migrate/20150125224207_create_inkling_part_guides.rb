class CreateInklingPartGuides < ActiveRecord::Migration
    def change
        create_table :inkling_part_guides do | t |
            t.string :kind
            t.integer :max_points
            t.integer :max_might_points
            t.integer :max_light_points
            t.integer :max_dark_points
        end
    end
end