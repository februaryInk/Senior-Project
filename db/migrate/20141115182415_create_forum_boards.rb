class CreateForumBoards < ActiveRecord::Migration
  def change
    create_table :forum_boards do |t|
      t.string :description
      t.string :group
      t.string :name

      t.timestamps
    end
  end
end
