class CreateFeedback < ActiveRecord::Migration
    def change
        create_table :feedback do | t |

            t.references :user, :foreign_key => true, :index => true
            t.references :manuscript, :foreign_key => true, :index => true
            
            t.text :content
            
            t.timestamps :null => false
        end
    end
end
