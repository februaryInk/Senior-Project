community_forums = [ 'Introduce Yourself', 'Questions and Answers', 'Wouldn\'t it be Nice if...', 'General Talk', 'Deep Thoughts', 'Good Books' ]
writing_forums = [ 'Advice', 'Characters', 'Grammar and Form', 'Playing with Plot', 'Revising and Polishing', 'Short Stories' ]

User.create( :email => 'testuser@example.com', :password => 'goodpassword', :password_confirmation => 'goodpassword', :username => 'Test User' )

for topic in community_forums do
    ForumBoard.create( :group => :community, :name => topic )
end

for topic in writing_forums do
    ForumBoard.create( :group => :writing, :name => topic )
end

User.first.forum_threads.create( :forum_board_id => 1, :name => 'Hi, I\'m a test user!' )
User.first.forum_threads.create( :forum_board_id => 1, :name => 'Any other users here?' )
User.first.forum_threads.create( :forum_board_id => 6, :name => 'Has anyone read my favorite book?' )

User.first.forum_posts.create( :content => 'I just wanted to say hello to y\'all!', :forum_thread_id => 1 )
User.first.forum_posts.create( :content => 'If there are, I say hi.', :forum_thread_id => 1 )
User.first.forum_posts.create( :content => 'I eagerly await your responses!', :forum_thread_id => 1 )
User.first.forum_posts.create( :content => 'I think it is the best.', :forum_thread_id => 3 )
User.first.forum_posts.create( :content => 'Hello?', :forum_thread_id => 1 )