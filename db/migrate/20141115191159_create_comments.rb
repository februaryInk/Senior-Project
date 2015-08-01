class CreateComments < ActiveRecord::Migration
    def change
        create_table :comments do | t |
    
            t.references :conversation, :foreign_key => true, :index => true
            t.references :user, :foreign_key => true, :index => true
        
            t.text :content
            
            t.timestamps :null => false
        end
        
        add_index :comments, :created_at
    end
end
