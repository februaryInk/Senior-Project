class CreateUsers < ActiveRecord::Migration
    def change
        create_table :users do | t |
        
            t.boolean :admin, :default => false
            
            t.string :email
            t.string :password_digest
            t.string :remember_digest
            t.string :simple_name
            t.string :username
            
            t.text :biography

            t.timestamps
        end
        
        add_index :users, :email, { :unique => true }
        add_index :users, :simple_name, { :unique => true }
    end
end
