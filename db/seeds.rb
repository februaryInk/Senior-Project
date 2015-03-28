community_forums = [ 'Introduce Yourself', 'Questions and Answers', 'Suggestions', 'General Talk', 'Deep Thoughts', 'Good Books' ]
writing_forums = [ 'Advice', 'Characters', 'Grammar and Form', 'Ideas Exchange', 'Playing with Plot', 'Revising and Polishing', 'Short Stories' ]

User.create( :admin => true, :biography => 'Greetings. I am the imaginary user created to test this site. I live in a small town, and I suppose I will stay here all my life. I go to church every Sunday and rollerskating every Friday. I lead a steady, same-old same-old life, and I like it best that way. I\'m also a site admin, so be nice.', :email => 'testuser@example.com', :password => 'goodpassword', :password_confirmation => 'goodpassword', :username => 'Test User' )
User.create( :admin => false, :biography => 'I live on the eastern coast of the United States, but it has always been my dream to move west. I\'ve always been a reader, but lately I\'ve been feeling the urge to write my own stories.', :email => 'margie@example.com', :password => 'goodpassword', :password_confirmation => 'goodpassword', :username => 'Margie' )

99.times do | n |
    username = Faker::Name.name
    email = "testuser-#{ n + 1 }@example.com"
    password = 'goodpassword'
    biography = Faker::Lorem.paragraph
    if ( /\A(?=.*[a-z0-9].*)([a-z0-9\-_.]+)([\s][a-z0-9\-_.]+)*\z/i.match( username ) ) then
        User.create!( :username => username, :biography => biography, :email => email, :password => password, :password_confirmation => password )
    end
end
    
for forum in community_forums do
    Forum.create( :group => :community, :name => forum )
end

for forum in writing_forums do
    Forum.create( :group => :writing, :name => forum )
end

User.find( 2 ).conversations.create( :forum_id => 1, :name => 'Hi, I\'m Margie!' )
User.find( 2 ).conversations.create( :forum_id => 10, :name => 'Starting my first story' )
User.find( 2 ).conversations.create( :forum_id => 6, :name => '"Wuthering Heights"' )

User.find( 2 ).comments.create( :content => 'I am new to this community. I just wanted to say hello to you all, and meet some people.', :conversation_id => 1 )
User.find( 1 ).comments.create( :content => 'Hey, Margie! Welcome to the community. Why don\'t you tell us a little about yourself? Are you a writer?', :conversation_id => 1 )
User.find( 2 ).comments.create( :content => 'I am thinking of writing a new take on Cinderella, but it has been done so many times that I\'m not even sure there is a new take. How can I switch it up?', :conversation_id => 2 )
User.find( 4 ).comments.create( :content => 'You could always try a new culture. The Chinese or Egyptian versions of Cinderella are sufficiently different from the European one.', :conversation_id => 2 )
User.find( 3 ).comments.create( :content => 'How about a gender switch?', :conversation_id => 2 )
User.find( 2 ).comments.create( :content => 'I\'ve seen Cinderella as the guy before ("Cinderellis and the Glass Hill"), but it was a good deal different from the traditional story.', :conversation_id => 2 )
User.find( 2 ).comments.create( :content => 'I know it is cliche to say some classic is your favorite book, but for me it\'s true. I love this book.', :conversation_id => 3 )
User.find( 1 ).comments.create( :content => 'Whoa, I have to disagree with you there. I had to read that book for an English class, and I could still barely make myself finish it.', :conversation_id => 3 )
User.find( 3 ).comments.create( :content => 'Oh, come on, Test User, what\'s not to like?', :conversation_id => 3 )

User.first.news_reports.create( :content => 'Our news feed is now up and running! This will allow us to keep you updated on new features as they are added and other site events. Meanwhile, we will continue to work on getting this site to a usable and friendly state. We will keep you posted as things progress.', :title => 'The News Feed' )

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
InklingPartGuide.create( :kind => 'boots-hind', :max_points => 2, :max_might_points => 0, :max_light_points => 2, :max_dark_points => 0 )
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