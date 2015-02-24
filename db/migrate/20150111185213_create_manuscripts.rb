class CreateManuscripts < ActiveRecord::Migration
    def change
        create_table :manuscripts do | t |
            t.references :user, :index => true
            t.string :title
            t.string :genre
            t.text :description
            t.integer :word_count
            t.integer :might_word_count
            t.integer :light_word_count
            t.integer :dark_word_count
            
            t.timestamps
        end
        
        add_index :manuscripts, :genre
    end
end
