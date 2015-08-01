class CreatePosts < ActiveRecord::Migration
    def change
        create_table :posts do | t |
        
            t.references :user, :foreign_key => true, :index => true
            
            t.text :content

            t.timestamps :null => false
        end
    end
end
