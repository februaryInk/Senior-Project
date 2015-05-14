# forums are auto-generated at this point by inserting them into the database.

class Forum < ActiveRecord::Base

    # RELATIONSHIPS

    has_many :conversations
end
