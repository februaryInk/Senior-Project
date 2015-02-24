community_forums = [ 'Introduce Yourself', 'Questions and Answers', 'Suggestions', 'General Talk', 'Deep Thoughts', 'Good Books' ]
writing_forums = [ 'Advice', 'Characters', 'Grammar and Form', 'Ideas Exchange', 'Playing with Plot', 'Revising and Polishing', 'Short Stories' ]

User.create( :admin => true, :biography => 'Greetings. I am the imaginary user created to test this site. I live in a small town, and I suppose I will stay here all my life. I go to church every Sunday and rollerskating every Friday. I lead a steady, same-old same-old life, and I like it best that way.', :email => 'testuser@example.com', :password => 'goodpassword', :password_confirmation => 'goodpassword', :username => 'Test User' )

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
User.first.news_reports.create( :content => 'We are in the proccess of creating inklings. There is a bit of trouble making them time dependent.', :title => 'Adding Inklings' )

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

InklingPartGuide.create( :kind => 'back', :max_points => 2, :max_might_points => 2, :max_light_points => 0, :max_dark_points => 2 )
InklingPartGuide.create( :kind => 'bib', :max_points => 1, :max_might_points => 0, :max_light_points => 1, :max_dark_points => 0 )
InklingPartGuide.create( :kind => 'boots-back', :max_points => 2, :max_might_points => 0, :max_light_points => 2, :max_dark_points => 0 )
InklingPartGuide.create( :kind => 'boots-front', :max_points => 2, :max_might_points => 0, :max_light_points => 2, :max_dark_points => 0 )
InklingPartGuide.create( :kind => 'chest', :max_points => 1, :max_might_points => 1, :max_light_points => 1, :max_dark_points => 0 )
InklingPartGuide.create( :kind => 'claws', :max_points => 2, :max_might_points => 0, :max_light_points => 0, :max_dark_points => 2 )
InklingPartGuide.create( :kind => 'ears', :max_points => 3, :max_might_points => 3, :max_light_points => 3, :max_dark_points => 3 )
InklingPartGuide.create( :kind => 'eye', :max_points => 2, :max_might_points => 2, :max_light_points => 2, :max_dark_points => 2 )
InklingPartGuide.create( :kind => 'face', :max_points => 3, :max_might_points => 3, :max_light_points => 3, :max_dark_points => 3 )
InklingPartGuide.create( :kind => 'scar', :max_points => 2, :max_might_points => 2, :max_light_points => 0, :max_dark_points => 0 )
InklingPartGuide.create( :kind => 'shadow', :max_points => 4, :max_might_points => 4, :max_light_points => 0, :max_dark_points => 0 )
InklingPartGuide.create( :kind => 'skirt', :max_points => 2, :max_might_points => 0, :max_light_points => 2, :max_dark_points => 0 )
InklingPartGuide.create( :kind => 'spots', :max_points => 4, :max_might_points => 0, :max_light_points => 0, :max_dark_points => 4 )
InklingPartGuide.create( :kind => 'stomach', :max_points => 1, :max_might_points => 1, :max_light_points => 0, :max_dark_points => 0 )
InklingPartGuide.create( :kind => 'star', :max_points => 2, :max_might_points => 0, :max_light_points => 2, :max_dark_points => 0 )
InklingPartGuide.create( :kind => 'tail', :max_points => 3, :max_might_points => 3, :max_light_points => 3, :max_dark_points => 3 )
InklingPartGuide.create( :kind => 'tooth', :max_points => 2, :max_might_points => 0, :max_light_points => 0, :max_dark_points => 2 )