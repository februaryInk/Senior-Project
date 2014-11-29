class CreateComments < ActiveRecord::Migration
    def change
        create_table :comments do | t |
            t.references :user, :index => true
            t.text :content
            t.references :conversation, :index => true

            t.timestamps
        end
        
        add_index :comments, :created_at
    end
end
