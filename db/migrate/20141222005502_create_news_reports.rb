class CreateNewsReports < ActiveRecord::Migration
    def change
        create_table :news_reports do | t |
        
            t.references :user, :foreign_key => true, :index => true
            
            t.string :title
            
            t.text :content

            t.timestamps :null => false
        end
    end
end
