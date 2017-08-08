class Feedback < ApplicationRecord

    # ASSOCIATIONS

    belongs_to :user
    belongs_to :manuscript
end
