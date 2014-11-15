class CreateForumPosts < ActiveRecord::Migration
  def change
    create_table :forum_posts do |t|
      t.integer :creator_id
      t.text :content
      t.integer :thread_id

      t.timestamps
    end
  end
end
