class CreateFeedback < ActiveRecord::Migration
    def change
        create_table :feedback do | t |

            t.references :user
            t.references :manuscript
            t.text :content
            
            t.timestamps null: false
        end
    end
end
