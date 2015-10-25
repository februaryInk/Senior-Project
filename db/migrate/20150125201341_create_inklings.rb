class CreateInklings < ActiveRecord::Migration
    def change
        create_table :inklings do | t |
        
            t.references :manuscript, :foreign_key => true, :index => true
            
            t.boolean :hardcore
            
            t.integer :revival_fee
            t.integer :revival_fee_currency
            t.integer :word_count_goal
            t.integer :word_rate_goal
            t.integer :word_rate_goal_basis
            
            t.string :revival_fee_currency
            
            t.timestamps :null => false
        end
    end
end
