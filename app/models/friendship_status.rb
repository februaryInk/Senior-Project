# Accepted: The friendship has been accepted and is active.
# Pending: The friend is pending and must accept the friendship before it can become active.
# Waiting: The friend is waiting and the user must accept the friendship before it can become active.

class FriendshipStatus < ActiveRecord::Base

    include CalledClassMethod

    # RELATIONSHIPS
    
    has_many :friendships
end
