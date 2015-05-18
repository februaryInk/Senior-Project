class CreateInklings < ActiveRecord::Migration
    def change
        create_table :inklings do | t |
        
            t.references :manuscript, :index => true
            t.references :user, :index => true
            
            t.boolean :hardcore
            
            t.integer :dark_points
            t.integer :light_points
            t.integer :might_points
            t.integer :points
            t.integer :revival_fee
            t.integer :revival_fee_currency
            t.integer :word_count_goal
            t.integer :word_rate_goal
            t.integer :word_rate_goal_basis
            
            t.timestamps :null => false
        end
    end
end
