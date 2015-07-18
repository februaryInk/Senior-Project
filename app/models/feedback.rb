class Feedback < ActiveRecord::Base

    # RELATIONSHIPS

    belongs_to :user
    belongs_to :manuscript
end
