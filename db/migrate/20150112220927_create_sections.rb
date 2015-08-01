class CreateSections < ActiveRecord::Migration
    def change
        create_table :sections do | t |
        
            t.references :manuscript, :foreign_key => true, :index => true
            
            t.boolean :published
            
            t.datetime :published_at
            
            t.integer :dark_word_count
            t.integer :light_word_count
            t.integer :might_word_count
            t.integer :position
            t.integer :word_count
            
            t.string :name
            
            t.text :content
            
            t.timestamps :null => false
        end
    end
end
