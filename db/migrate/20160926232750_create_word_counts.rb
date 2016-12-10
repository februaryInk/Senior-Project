class CreateWordCounts < ActiveRecord::Migration
    def change
        create_table( :word_counts ) do | t |
          
            t.references :manuscript, :foreign_key => true, :index => true
            t.references :user, :foreign_key => true, :index => true
            
            t.datetime :completed_at
            
            t.integer :words

            t.timestamps :null => false
        end
    end
end
