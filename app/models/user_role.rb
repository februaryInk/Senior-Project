class UserRole < ActiveRecord::Base

    include CalledClassMethod

    # VALIDATIONS

    validates :name, :uniqueness => { :case_sensitive => true }

    # RELATIONSHIPS

    has_many :users
end
