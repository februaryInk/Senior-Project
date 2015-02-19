community_forums = [ 'Introduce Yourself', 'Questions and Answers', 'Suggestions', 'General Talk', 'Deep Thoughts', 'Good Books' ]
writing_forums = [ 'Advice', 'Characters', 'Grammar and Form', 'Ideas Exchange', 'Playing with Plot', 'Revising and Polishing', 'Short Stories' ]

User.create( :admin => true, :biography => 'I live in a small town, and I suppose I will stay here all my life. I go to church every Sunday and rollerskating every Friday. I lead a steady, same-old same-old life, and I like it best that way.', :email => 'testuser@example.com', :password => 'goodpassword', :password_confirmation => 'goodpassword', :username => 'Test User' )

99.times do | n |
    username = Faker::Name.name
    email = "testuser-#{ n + 1 }@example.com"
    password = 'goodpassword'
    if ( /\A(?=.*[a-z0-9].*)([a-z0-9\-_.]+)([\s][a-z0-9\-_.]+)*\z/i.match( username ) ) then
        User.create!( :username => username, :email => email, :password => password, :password_confirmation => password )
    end
end
    
for forum in community_forums do
    Forum.create( :group => :community, :name => forum )
end

for forum in writing_forums do
    Forum.create( :group => :writing, :name => forum )
end

User.first.conversations.create( :forum_id => 1, :name => 'Hi, I\'m a test user!' )
User.first.conversations.create( :forum_id => 1, :name => 'Any other users here?' )
User.first.conversations.create( :forum_id => 6, :name => 'Has anyone read my favorite book?' )

User.first.comments.create( :content => 'I just wanted to say hello to y\'all!', :conversation_id => 1 )
User.first.comments.create( :content => 'If there are, I say hi.', :conversation_id => 2 )
User.first.comments.create( :content => 'I eagerly await your responses!', :conversation_id => 1 )
User.first.comments.create( :content => 'I think it is the best.', :conversation_id => 3 )
User.first.comments.create( :content => 'Hello?', :conversation_id => 2 )

User.first.news_reports.create( :content => 'Our news feed is now up and running! We will keep you updated on new features and site events.', :title => 'The News Feed' )

User.first.friendships.create( :friend_id => 2, :status => 'accepted' )
User.first.reciprocated_friendships.create( :user_id => 2, :status => 'accepted' )
User.first.friendships.create( :friend_id => 3, :status => 'pending' )
User.first.reciprocated_friendships.create( :user_id => 3, :status => 'waiting' )
User.first.friendships.create( :friend_id => 4, :status => 'accepted' )
User.first.reciprocated_friendships.create( :user_id => 4, :status => 'accepted' )
User.first.friendships.create( :friend_id => 5, :status => 'waiting' )
User.first.reciprocated_friendships.create( :user_id => 5, :status => 'pending' )
User.first.friendships.create( :friend_id => 6, :status => 'pending' )
User.first.reciprocated_friendships.create( :user_id => 6, :status => 'waiting' )
User.first.friendships.create( :friend_id => 7, :status => 'accepted' )
User.first.reciprocated_friendships.create( :user_id => 7, :status => 'accepted' )

User.first.manuscripts.create( :title => 'Beauty and the Beast', :genre => 'fantasy', :description => 'In a kingdom far, far away, there lives a wealthy merchant and his five beautiful children. The family has always been well off, but when misfortune strikes, they loose everything and must sell their town home to move to a quiet village to live humbly. But when they arrive, they begin to hear rumors that the village holds a secret. It is said that in the dark forest beyond the village gates, there dwells a terrible Beast...' )
User.first.sections.create( :name => 'Chapter One', :manuscript_id => 1, :position => 1, :content => 'Once upon a time, there lived a wealthy merchant and his family of two sons and three daughters. The sons were handsome and well-mannered, the daughters were beautiful and accomplished. The people of the seaside town where they lived thought very well of them, though they might have admitted that the children were a bit lazy, for their father saw their every need provided for and they never had to work for anything. The merchant was a shrewd business man and had built his fortune from nearly nothing. Little could he know that very soon, to nearly nothing he would return...' )
User.first.sections.create( :name => 'Chapter Two', :manuscript_id => 1, :position => 2, :content => 'Once upon a time, there lived a wealthy merchant and his family of two sons and three daughters. The sons were handsome and well-mannered, the daughters were beautiful and accomplished. The people of the seaside town where they lived thought very well of them, though they might have admitted that the children were a bit lazy, for their father saw their every need provided for and they never had to work for anything. The merchant was a shrewd business man and had built his fortune from nearly nothing. Little could he know that very soon, to nearly nothing he would return...' )

BodyPart.create( :selector => '#face-000', :kind => 'face', :adventurous_points => 0, :romantic_points => 0, :scary_points => 0 )
BodyPart.create( :selector => '#face-001', :kind => 'face', :adventurous_points => 0, :romantic_points => 0, :scary_points => 1 )
BodyPart.create( :selector => '#face-002', :kind => 'face', :adventurous_points => 0, :romantic_points => 0, :scary_points => 2 )
BodyPart.create( :selector => '#face-003', :kind => 'face', :adventurous_points => 0, :romantic_points => 0, :scary_points => 3 )
BodyPart.create( :selector => '#face-010', :kind => 'face', :adventurous_points => 0, :romantic_points => 1, :scary_points => 0 )
BodyPart.create( :selector => '#face-011', :kind => 'face', :adventurous_points => 0, :romantic_points => 1, :scary_points => 1 )
BodyPart.create( :selector => '#face-012', :kind => 'face', :adventurous_points => 0, :romantic_points => 1, :scary_points => 2 )
BodyPart.create( :selector => '#face-020', :kind => 'face', :adventurous_points => 0, :romantic_points => 2, :scary_points => 0 )
BodyPart.create( :selector => '#face-021', :kind => 'face', :adventurous_points => 0, :romantic_points => 2, :scary_points => 1 )
BodyPart.create( :selector => '#face-030', :kind => 'face', :adventurous_points => 0, :romantic_points => 3, :scary_points => 0 )
BodyPart.create( :selector => '#face-100', :kind => 'face', :adventurous_points => 1, :romantic_points => 0, :scary_points => 0 )
BodyPart.create( :selector => '#face-101', :kind => 'face', :adventurous_points => 1, :romantic_points => 0, :scary_points => 1 )
BodyPart.create( :selector => '#face-102', :kind => 'face', :adventurous_points => 1, :romantic_points => 0, :scary_points => 2 )
BodyPart.create( :selector => '#face-110', :kind => 'face', :adventurous_points => 1, :romantic_points => 1, :scary_points => 0 )
BodyPart.create( :selector => '#face-111', :kind => 'face', :adventurous_points => 1, :romantic_points => 1, :scary_points => 1 )
BodyPart.create( :selector => '#face-200', :kind => 'face', :adventurous_points => 2, :romantic_points => 0, :scary_points => 0 )
BodyPart.create( :selector => '#face-201', :kind => 'face', :adventurous_points => 2, :romantic_points => 0, :scary_points => 1 )
BodyPart.create( :selector => '#face-210', :kind => 'face', :adventurous_points => 2, :romantic_points => 1, :scary_points => 0 )
BodyPart.create( :selector => '#face-300', :kind => 'face', :adventurous_points => 3, :romantic_points => 0, :scary_points => 0 )

BodyPart.create( :selector => '#ears-000', :kind => 'ears', :adventurous_points => 0, :romantic_points => 0, :scary_points => 0 )
BodyPart.create( :selector => '#ears-001', :kind => 'ears', :adventurous_points => 0, :romantic_points => 0, :scary_points => 1 )
BodyPart.create( :selector => '#ears-002', :kind => 'ears', :adventurous_points => 0, :romantic_points => 0, :scary_points => 2 )
BodyPart.create( :selector => '#ears-003', :kind => 'ears', :adventurous_points => 0, :romantic_points => 0, :scary_points => 3 )
BodyPart.create( :selector => '#ears-010', :kind => 'ears', :adventurous_points => 0, :romantic_points => 1, :scary_points => 0 )
BodyPart.create( :selector => '#ears-011', :kind => 'ears', :adventurous_points => 0, :romantic_points => 1, :scary_points => 1 )
BodyPart.create( :selector => '#ears-012', :kind => 'ears', :adventurous_points => 0, :romantic_points => 1, :scary_points => 2 )
BodyPart.create( :selector => '#ears-020', :kind => 'ears', :adventurous_points => 0, :romantic_points => 2, :scary_points => 0 )
BodyPart.create( :selector => '#ears-021', :kind => 'ears', :adventurous_points => 0, :romantic_points => 2, :scary_points => 1 )
BodyPart.create( :selector => '#ears-030', :kind => 'ears', :adventurous_points => 0, :romantic_points => 3, :scary_points => 0 )
BodyPart.create( :selector => '#ears-100', :kind => 'ears', :adventurous_points => 1, :romantic_points => 0, :scary_points => 0 )
BodyPart.create( :selector => '#ears-101', :kind => 'ears', :adventurous_points => 1, :romantic_points => 0, :scary_points => 1 )
BodyPart.create( :selector => '#ears-102', :kind => 'ears', :adventurous_points => 1, :romantic_points => 0, :scary_points => 2 )
BodyPart.create( :selector => '#ears-110', :kind => 'ears', :adventurous_points => 1, :romantic_points => 1, :scary_points => 0 )
BodyPart.create( :selector => '#ears-111', :kind => 'ears', :adventurous_points => 1, :romantic_points => 1, :scary_points => 1 )
BodyPart.create( :selector => '#ears-200', :kind => 'ears', :adventurous_points => 2, :romantic_points => 0, :scary_points => 0 )
BodyPart.create( :selector => '#ears-201', :kind => 'ears', :adventurous_points => 2, :romantic_points => 0, :scary_points => 1 )
BodyPart.create( :selector => '#ears-210', :kind => 'ears', :adventurous_points => 2, :romantic_points => 1, :scary_points => 0 )
BodyPart.create( :selector => '#ears-300', :kind => 'ears', :adventurous_points => 3, :romantic_points => 0, :scary_points => 0 )

BodyPart.create( :selector => '#eyes-000', :kind => 'eyes', :adventurous_points => 0, :romantic_points => 0, :scary_points => 0 )
BodyPart.create( :selector => '#eyes-001', :kind => 'eyes', :adventurous_points => 0, :romantic_points => 0, :scary_points => 1 )
BodyPart.create( :selector => '#eyes-002', :kind => 'eyes', :adventurous_points => 0, :romantic_points => 0, :scary_points => 2 )
BodyPart.create( :selector => '#eyes-010', :kind => 'eyes', :adventurous_points => 0, :romantic_points => 1, :scary_points => 0 )
BodyPart.create( :selector => '#eyes-011', :kind => 'eyes', :adventurous_points => 0, :romantic_points => 1, :scary_points => 1 )
BodyPart.create( :selector => '#eyes-020', :kind => 'eyes', :adventurous_points => 0, :romantic_points => 2, :scary_points => 0 )
BodyPart.create( :selector => '#eyes-100', :kind => 'eyes', :adventurous_points => 1, :romantic_points => 0, :scary_points => 0 )
BodyPart.create( :selector => '#eyes-101', :kind => 'eyes', :adventurous_points => 1, :romantic_points => 0, :scary_points => 1 )
BodyPart.create( :selector => '#eyes-110', :kind => 'eyes', :adventurous_points => 1, :romantic_points => 1, :scary_points => 0 )
BodyPart.create( :selector => '#eyes-200', :kind => 'eyes', :adventurous_points => 2, :romantic_points => 0, :scary_points => 0 )

BodyPart.create( :selector => '#tail-000', :kind => 'tail', :adventurous_points => 0, :romantic_points => 0, :scary_points => 0 )
BodyPart.create( :selector => '#tail-001', :kind => 'tail', :adventurous_points => 0, :romantic_points => 0, :scary_points => 1 )
BodyPart.create( :selector => '#tail-002', :kind => 'tail', :adventurous_points => 0, :romantic_points => 0, :scary_points => 2 )
BodyPart.create( :selector => '#tail-003', :kind => 'tail', :adventurous_points => 0, :romantic_points => 0, :scary_points => 3 )
BodyPart.create( :selector => '#tail-010', :kind => 'tail', :adventurous_points => 0, :romantic_points => 1, :scary_points => 0 )
BodyPart.create( :selector => '#tail-011', :kind => 'tail', :adventurous_points => 0, :romantic_points => 1, :scary_points => 1 )
BodyPart.create( :selector => '#tail-012', :kind => 'tail', :adventurous_points => 0, :romantic_points => 1, :scary_points => 2 )
BodyPart.create( :selector => '#tail-020', :kind => 'tail', :adventurous_points => 0, :romantic_points => 2, :scary_points => 0 )
BodyPart.create( :selector => '#tail-021', :kind => 'tail', :adventurous_points => 0, :romantic_points => 2, :scary_points => 1 )
BodyPart.create( :selector => '#tail-030', :kind => 'tail', :adventurous_points => 0, :romantic_points => 3, :scary_points => 0 )
BodyPart.create( :selector => '#tail-100', :kind => 'tail', :adventurous_points => 1, :romantic_points => 0, :scary_points => 0 )
BodyPart.create( :selector => '#tail-101', :kind => 'tail', :adventurous_points => 1, :romantic_points => 0, :scary_points => 1 )
BodyPart.create( :selector => '#tail-102', :kind => 'tail', :adventurous_points => 1, :romantic_points => 0, :scary_points => 2 )
BodyPart.create( :selector => '#tail-110', :kind => 'tail', :adventurous_points => 1, :romantic_points => 1, :scary_points => 0 )
BodyPart.create( :selector => '#tail-111', :kind => 'tail', :adventurous_points => 1, :romantic_points => 1, :scary_points => 1 )
BodyPart.create( :selector => '#tail-200', :kind => 'tail', :adventurous_points => 2, :romantic_points => 0, :scary_points => 0 )
BodyPart.create( :selector => '#tail-201', :kind => 'tail', :adventurous_points => 2, :romantic_points => 0, :scary_points => 1 )
BodyPart.create( :selector => '#tail-210', :kind => 'tail', :adventurous_points => 2, :romantic_points => 1, :scary_points => 0 )
BodyPart.create( :selector => '#tail-300', :kind => 'tail', :adventurous_points => 3, :romantic_points => 0, :scary_points => 0 )

BodyPart.create( :selector => '#back-000', :kind => 'back', :adventurous_points => 0, :romantic_points => 0, :scary_points => 0 )
BodyPart.create( :selector => '#back-001', :kind => 'back', :adventurous_points => 0, :romantic_points => 0, :scary_points => 1 )
BodyPart.create( :selector => '#back-002', :kind => 'back', :adventurous_points => 0, :romantic_points => 0, :scary_points => 2 )
BodyPart.create( :selector => '#back-100', :kind => 'back', :adventurous_points => 1, :romantic_points => 0, :scary_points => 0 )
BodyPart.create( :selector => '#back-101', :kind => 'back', :adventurous_points => 1, :romantic_points => 0, :scary_points => 1 )
BodyPart.create( :selector => '#back-200', :kind => 'back', :adventurous_points => 2, :romantic_points => 0, :scary_points => 0 )

BodyPart.create( :selector => '#chest-000', :kind => 'chest', :adventurous_points => 0, :romantic_points => 0, :scary_points => 0 )
BodyPart.create( :selector => '#chest-010', :kind => 'chest', :adventurous_points => 0, :romantic_points => 1, :scary_points => 0 )
BodyPart.create( :selector => '#chest-100', :kind => 'chest', :adventurous_points => 1, :romantic_points => 0, :scary_points => 0 )

BodyPart.create( :selector => '#star-010', :kind => 'other', :adventurous_points => 0, :romantic_points => 1, :scary_points => 0 )
BodyPart.create( :selector => '#star-020', :kind => 'other', :adventurous_points => 0, :romantic_points => 2, :scary_points => 0 )

BodyPart.create( :selector => '#scar-100', :kind => 'other', :adventurous_points => 1, :romantic_points => 0, :scary_points => 0 )
BodyPart.create( :selector => '#scar-200', :kind => 'other', :adventurous_points => 2, :romantic_points => 0, :scary_points => 0 )

BodyPart.create( :selector => '#skirt-010', :kind => 'other', :adventurous_points => 0, :romantic_points => 1, :scary_points => 0 )
BodyPart.create( :selector => '#skirt-020', :kind => 'other', :adventurous_points => 0, :romantic_points => 2, :scary_points => 0 )

BodyPart.create( :selector => '#bib-010', :kind => 'other', :adventurous_points => 0, :romantic_points => 1, :scary_points => 0 )

BodyPart.create( :selector => '#boots-front-010', :kind => 'other', :adventurous_points => 0, :romantic_points => 1, :scary_points => 0 )
BodyPart.create( :selector => '#boots-front-020', :kind => 'other', :adventurous_points => 0, :romantic_points => 2, :scary_points => 0 )

BodyPart.create( :selector => '#boots-back-010', :kind => 'other', :adventurous_points => 0, :romantic_points => 1, :scary_points => 0 )
BodyPart.create( :selector => '#boots-back-020', :kind => 'other', :adventurous_points => 0, :romantic_points => 2, :scary_points => 0 )