class CreateFeedback < ActiveRecord::Migration
    def change
        create_table :feedback do | t |

            t.references :user, :index => true
            t.references :manuscript, :index => true
            
            t.text :content
            
            t.timestamps :null => false
        end
    end
end
