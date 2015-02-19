class CreateInklingPartTemplates < ActiveRecord::Migration
    def change
        create_table :inkling_part_templates, :id => false do | t |
            t.integer :max_points
            t.integer :max_adventurous_points
            t.integer :max_romantic_points
            t.integer :max_scary_points
        end
    end
end
