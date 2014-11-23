class CreateForumThreads < ActiveRecord::Migration
    def change
        create_table :forum_threads do | t |
            t.references :forum_board, :index => true
            t.references :user, :index => true
            t.string :name
            t.text :content

            t.timestamps
        end
        
        add_index :forum_threads, :created_at
    end
end
