class CreateFriendshipStatuses < ActiveRecord::Migration
    def change
        create_table :friendship_statuses do | t |
        
            t.string :name

            t.timestamps :null => false
        end
    end
end
