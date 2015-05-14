class Feedback < ActiveRecord::Base

    # RELATIONSHIPS

    belongs_to :user
    belongs_to :manuscripts
end
