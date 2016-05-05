class CreateFaqs < ActiveRecord::Migration
    def change
        create_table :faqs do | t |
            
            t.references :faq_category, :foreign_key => true, :index => true
            
            t.integer :position, :default => 0
            
            t.text :answer
            t.text :question
            
            t.timestamps :null => false
        end
    end
end
