class CreateInklings < ActiveRecord::Migration
    def change
        create_table :inklings do | t |
            t.references :user, :index => true
            t.references :manuscript, :index => true
            t.integer :word_count_goal
            t.integer :word_rate_goal
            t.integer :word_rate_goal_basis
            t.integer :revival_fee
            t.integer :revival_fee_currency
            t.boolean :hardcore
            t.integer :points
            t.integer :might_points
            t.integer :light_points
            t.integer :dark_points

            t.timestamps
        end
    end
end
