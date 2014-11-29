class CreateConversations < ActiveRecord::Migration
    def change
        create_table :conversations do | t |
            t.references :forum, :index => true
            t.references :user, :index => true
            t.string :name
            t.text :content

            t.timestamps
        end
        
        add_index :conversations, :created_at
    end
end
