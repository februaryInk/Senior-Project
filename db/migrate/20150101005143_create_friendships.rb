class CreateFriendships < ActiveRecord::Migration
    def change
        create_table :friendships do | t |
        
            t.references :user, :foreign_key => true, :index => true
            t.references :friend, :foreign_key => true, :index => true
            t.references :friendship_status, :foreign_key => true, :index => true

            t.timestamps :null => false
        end
        
        add_index :friendships, [ :user_id, :friend_id ], :unique => true
    end
end
