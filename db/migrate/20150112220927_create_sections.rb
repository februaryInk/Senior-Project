class CreateSections < ActiveRecord::Migration
    def change
        create_table :sections do | t |
            t.references :user, :index => true
            t.references :manuscript, :index => true
            t.integer :position
            t.string :name
            t.text :content
            t.integer :word_count
            t.integer :might_word_count
            t.integer :light_word_count
            t.integer :dark_word_count
            
            t.timestamps
        end
    end
end
