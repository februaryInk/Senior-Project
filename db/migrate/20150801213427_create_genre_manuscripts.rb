class CreateGenreManuscripts < ActiveRecord::Migration
    def change
        create_table :genre_manuscripts do | t |
            t.references :genre, :foreign_key => true, :index => true
            t.references :manuscript, :foreign_key => true, :index => true

            t.timestamps :null => false
        end
    end
end
