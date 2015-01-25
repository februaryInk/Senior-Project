class CreateSections < ActiveRecord::Migration
    def change
        create_table :sections do | t |
            t.references :user, :index => true
            t.references :manuscript, :index => true
            t.integer :position
            t.string :name
            t.text :content
            t.integer :word_count
            t.integer :adventurous_word_count
            t.integer :romantic_word_count
            t.integer :scary_word_count
            
            t.timestamps
        end
    end
end
