class UserRole < ApplicationRecord

    include CallableByName

    # VALIDATIONS

    validates :name, :uniqueness => { :case_sensitive => true }

    # ASSOCIATIONS

    has_many :users
end
