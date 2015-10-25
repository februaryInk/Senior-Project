class CreateManuscripts < ActiveRecord::Migration
    def change
        create_table :manuscripts do | t |
        
            t.references :rating, :foreign_key => true, :index => true
            t.references :user, :foreign_key => true, :index => true
            
            t.integer :word_count
            
            t.string :genre
            t.string :title
            
            t.text :description
            
            t.timestamps :null => false
        end
        
        add_index :manuscripts, :genre
    end
end
