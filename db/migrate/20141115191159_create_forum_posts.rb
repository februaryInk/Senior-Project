class CreateForumPosts < ActiveRecord::Migration
    def change
        create_table :forum_posts do | t |
            t.references :user, :index => true
            t.text :content
            t.references :forum_thread, :index => true

            t.timestamps
        end
        
        add_index :forum_posts, :created_at
    end
end
