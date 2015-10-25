require 'faker'

User.create(
    :activated => true,
    :activated_at => Time.zone.now,
    :biography => 'Greetings. I am the imaginary user created to test this site. I live in a small town, and I suppose I will stay here all my life. I go to church every Sunday and rollerskating every Friday. I lead a steady, same-old same-old life, and I like it best that way. I\'m also a site admin, so be nice.',
    :email => 'testuser@example.com',
    :password => 'goodpassword',
    :password_confirmation => 'goodpassword',
    :user_role_id => UserRole.called( 'Admin' ).id,
    :username => 'Test User' )
    
User.create(
    :activated => true,
    :activated_at => Time.zone.now,
    :biography => 'I live on the eastern coast of the United States, but it has always been my dream to move west. I\'ve always been a reader, but lately I\'ve been feeling the urge to write my own stories.',
    :email => 'margie@example.com',
    :password => 'goodpassword',
    :password_confirmation => 'goodpassword',
    :user_role_id => UserRole.called( 'Standard' ).id,
    :username => 'Margie' )

99.times do | n |

    username = ''

    loop do
        username = Faker::Name.name
        break if ( /\A(?=.*[a-z0-9].*)([a-z0-9\-_.]+)([\s][a-z0-9\-_.]+)*\z/i ).match( username )
    end
    
    email = "testuser-#{ n + 1 }@example.com"
    password = 'goodpassword'
    biography = Faker::Lorem.paragraph
    
    User.create!( 
        :activated => true,
        :activated_at => Time.zone.now, 
        :biography => biography, 
        :email => email, 
        :password => password, 
        :password_confirmation => password,
        :user_role_id => UserRole.called( 'Standard' ).id,
        :username => username )
end

random_conversations = [
    'Great Book Series',
    'The Lounge',
    'Talk to Me.',
    'The Worst Thing You\'ve Ever Read' ]

random_comments = [ 
    'That\'s what she said.',
    'Do I know you?',
    'I agree completely.',
    'I can\'t wait for the next book!',
    'My reading list is sooo long right now.',
    'My friend, you and I are in the same boat.',
    'I\'ve never met you before in my life.',
    'As they say, blood is thicker than water.',
    'PM me for more details.',
    'Plot twist!',
    'I arrange my books by smell.',
    'I am stuck. I am so, so stuck. Can anyone help me out of this writer\'s block I\'m in?',
    'How much Red Bull is too much?',
    'If you have to ask, it\'s too much.',
    'I am an artist, caught in the ever-shifting kaleidescope of my own emotions.',
    'They have medication for that.',
    'Jenny? Is that you?',
    'That is so true.',
    'I can\'t believe you just said that.' ]
    
random_conversations.each do | conversation |

    user = User.offset( rand( User.count ) ).first

    Conversation.create(
        :name => conversation,
        :forum_id => Forum.offset( rand( Forum.count ) ).first.id,
        :user_id => user.id )
        
    Comment.create(
        :content => random_comments.pop,
        :conversation_id => Conversation.last.id,
        :user_id => user.id )
end

random_comments.each do | comment |

    Comment.create(
        :content => comment,
        :conversation_id => Conversation.offset( rand( Conversation.count ) ).first.id,
        :user_id => User.offset( rand( User.count ) ) )
end     

Conversation.create( 
    :forum_id => Forum.called( 'Introduce Yourself' ).id,
    :name => 'Hi, I\'m New!' )
    
first_conversation_comments = [
    'I am new to this community. I just wanted to say hello to you all, and meet some people.',
    'Hey, welcome to the community! Why don\'t you tell us a little about yourself? Are you a writer?' ]
    
first_conversation_comments.each do | comment |
    
    Comment.create(
        :content => comment,
        :conversation_id => Conversation.last.id,
        :user_id => User.offset( rand( User.count ) ).first.id )
end
    
Conversation.create( 
    :forum_id => Forum.called( 'Playing with Plot' ).id,
    :name => 'Starting my first story' )
    
second_conversation_comments = [
    'I am thinking of writing a new take on Cinderella, but it has been done so many times that I\'m not even sure there is a new take. How can I switch it up?',
    'You could always try a new culture. The Chinese or Egyptian versions of Cinderella are sufficiently different from the European one.',
    'How about a gender switch?',
    'I\'ve seen Cinderella as the guy before ("Cinderellis and the Glass Hill"), but it was a good deal different from the traditional story.' ]
    
second_conversation_comments.each do | comment |
    
    Comment.create(
        :content => comment,
        :conversation_id => Conversation.last.id,
        :user_id => User.offset(rand(User.count)).first.id )
end
    
Conversation.create( 
    :forum_id => Forum.called( 'Good Books' ).id,
    :name => '"Wuthering Heights"')
    
third_conversation_comments = [
    'I know it is cliche to say some classic is your favorite book, but for me it\'s true. I love this book.',
    'Whoa, I have to disagree with you there. I had to read that book for an English class, and I could barely make myself finish it.',
    'Oh, come on, what\'s not to like?' ]
    
third_conversation_comments.each do | comment |
    
    Comment.create(
        :content => comment,
        :conversation_id => Conversation.last.id,
        :user_id => User.offset( rand( User.count ) ).first.id )
end

User.first.news_reports.create( 
    :content => 'Our news feed is now up and running! This will allow us to keep you updated on new features as they are added and other site events. Meanwhile, we will continue to work on getting this site to a usable and friendly state. We will keep you posted as things progress.', 
    :title => 'The News Feed' )
    
800.times do | n |

    user_1 = nil
    user_2 = nil

    loop do
        
        user_1 = User.offset( rand( User.count ) ).first
        user_2 = User.offset( rand( User.count ) ).first
        
        break if ( user_1 != user_2 ) && !( user_1.friends.include?( user_2 ) )
    end
    
    status = [ 'Accepted', 'Pending', 'Waiting' ].sample
    
    reciprocal_status =
    case status
    when 'Accepted'
        'Accepted'
    when 'Pending'
        'Waiting'
    when 'Waiting'
        'Pending'
    end

    Friendship.create(
        :friend_id => user_1.id,
        :friendship_status_id => FriendshipStatus.called( status ).id,
        :user_id => user_2.id
    )
        
    Friendship.create(
        :friend_id => user_2.id,
        :friendship_status_id => FriendshipStatus.called( reciprocal_status ).id,
        :user_id => user_1.id
    )
end

User.all.each do | user |

    manuscript = Manuscript.create(
        :description => Faker::Lorem.paragraph,
        :rating_id => Rating.offset( rand( Rating.count ) ).first.id,
        :title => Faker::Lorem.word(3),
        :user_id => user.id,
        :genre_ids => [
            Genre.offset( rand( Genre.count ) ).first.id
        ],
        :inkling_attributes => {
            :hardcore => [ false, true ].sample,
            :revival_fee => [ 0, 10, 100 ].sample,
            :revival_fee_currency => 'Points',
            :word_count_goal => [ 40000, 60000, 80000 ].sample,
            :word_rate_goal => [ 100, 500, 1000 ].sample,
            :word_rate_goal_basis => [ 1, 3, 7 ].sample
        }
    )
end
