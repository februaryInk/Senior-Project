class CreateForumThreads < ActiveRecord::Migration
  def change
    create_table :forum_threads do |t|
      t.integer :board_id
      t.integer :creator_id
      t.text :first_post
      t.string :name

      t.timestamps
    end
  end
end
