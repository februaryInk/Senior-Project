class CreateUsers < ActiveRecord::Migration
    def change
        create_table :users do | t |
            
            t.references :user_role, :foreign_key => true, :index => true
        
            t.boolean :activated, :default => false
            
            t.datetime :activated_at
            t.datetime :reset_sent_at
            
            t.string :activation_digest
            t.string :email
            t.string :password_digest
            t.string :remember_digest
            t.string :reset_digest
            t.string :simple_name
            t.string :time_zone, :default => ''
            t.string :username
            
            t.text :biography

            t.timestamps :null => false
        end
        
        add_index :users, :email, { :unique => true }
        add_index :users, :simple_name, { :unique => true }
    end
end
