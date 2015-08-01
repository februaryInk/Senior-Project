class CreateConversations < ActiveRecord::Migration
    def change
        create_table :conversations do | t |
        
            t.references :forum, :foreign_key => true, :index => true
            t.references :user, :foreign_key => true, :index => true
            
            t.string :name

            t.timestamps :null => false
        end
        
        add_index :conversations, :created_at
    end
end
