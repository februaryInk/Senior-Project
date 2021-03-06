# Accepted: The friendship has been accepted and is active.
# Pending: The friend is pending and must accept the friendship before it can become active.
# Waiting: The friend is waiting and the user must accept the friendship before it can become active.

class FriendshipStatus < ApplicationRecord

    include CallableByName

    # ASSOCIATIONS
    
    has_many :friendships
end
