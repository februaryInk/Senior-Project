community_forums = [ 'Introduce Yourself', 'Questions and Answers', 'Wouldn\'t it be Nice if...', 'General Talk', 'Deep Thoughts', 'Good Books' ]
writing_forums = [ 'Advice', 'Characters', 'Grammar and Form', 'Playing with Plot', 'Revising and Polishing', 'Short Stories' ]

User.create( :email => 'testuser@example.com', :password => 'goodpassword', :password_confirmation => 'goodpassword', :username => 'Test User' )

99.times do | n |
    username = Faker::Name.name
    email = "testuser-#{ n + 1 }@example.com"
    password = 'goodpassword'
    User.create!( :username => username, :email => email, :password => password, :password_confirmation => password )
end
    
for forum in community_forums do
    Forum.create( :group => :community, :name => forum )
end

for forum in writing_forums do
    Forum.create( :group => :writing, :name => forum )
end

User.first.conversations.create( :content => 'My hobbies include reading and gardening.', :forum_id => 1, :name => 'Hi, I\'m a test user!' )
User.first.conversations.create( :content => 'It\'s been pretty quiet around here.', :forum_id => 1, :name => 'Any other users here?' )
User.first.conversations.create( :content => 'It is my favorite.', :forum_id => 6, :name => 'Has anyone read my favorite book?' )

User.first.comments.create( :content => 'I just wanted to say hello to y\'all!', :conversation_id => 1 )
User.first.comments.create( :content => 'If there are, I say hi.', :conversation_id => 2 )
User.first.comments.create( :content => 'I eagerly await your responses!', :conversation_id => 1 )
User.first.comments.create( :content => 'I think it is the best.', :conversation_id => 3 )
User.first.comments.create( :content => 'Hello?', :conversation_id => 2 )