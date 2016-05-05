class Feedback < ActiveRecord::Base

    # ASSOCIATIONS

    belongs_to :user
    belongs_to :manuscript
end
