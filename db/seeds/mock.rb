require 'faker'

unless User.exists?( { :email => 'testuser@example.com' } )
    User.create(
        :activated => true,
        :activated_at => Time.zone.now,
        :biography => 'Greetings. I am the imaginary user created to test this site. I live in a small town, and I suppose I will stay here all my life. I go to church every Sunday and rollerskating every Friday. I lead a steady, same-old same-old life, and I like it best that way. I\'m also a site admin, so be nice.',
        :email => 'testuser@example.com',
        :password => 'goodpassword',
        :password_confirmation => 'goodpassword',
        :user_role_id => UserRole.called( 'Admin' ).id,
        :username => 'Test User' 
    )
end

unless User.exists?( { :email => 'margie@example.com' } )
    User.create(
        :activated => true,
        :activated_at => Time.zone.now,
        :biography => 'I live on the eastern coast of the United States, but it has always been my dream to move west. I\'ve always been a reader, but lately I\'ve been feeling the urge to write my own stories.',
        :email => 'margie@example.com',
        :password => 'goodpassword',
        :password_confirmation => 'goodpassword',
        :user_role_id => UserRole.called( 'Standard' ).id,
        :username => 'Margie' 
    )
end

difference = 99 - User.count

( difference > 0 ? difference : 0 ).times do | n |

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
        :username => username 
    )
end

difference = 100 - Conversation.count

( difference > 0 ? difference : 0 ).times do 

    user = User.offset( rand( User.count ) ).first
    
    conversation = Conversation.create(
        :forum_id => Forum.offset( rand( Forum.count ) ).first.id,
        :name => Faker::Lorem.words.join( ' ' ),
        :user_id => user.id
    )
    
    15.times do
        
        Comment.create(
            :content => Faker::Lorem.sentences.join( ' ' ),
            :conversation_id => conversation.id,
            :user_id => [ true, false, false ].sample ? user.id : User.offset( rand( User.count ) ).first.id
        )
    end
end

difference = 15 - NewsReport.count

( difference > 0 ? difference : 0 ).times do

    NewsReport.create( 
        :content => Faker::Lorem.paragraphs.join( "\r\n\r\n" ), 
        :title => Faker::Lorem.words.join( ' ' ).titleize,
        :user_id => User.where( :user_role_id => UserRole.called( 'Admin' ).id ).pluck( :id ).sample
    )
end

difference = 800 - Friendship.count

( difference > 0 ? difference : 0 ).times do | n |

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

difference = 15 - Faq.count

( difference > 0 ? difference : 0 ).times do
    
    faq_category_id = FaqCategory.offset( rand( FaqCategory.count ) ).first.id
    position = Faq.where( :faq_category_id => faq_category_id ).count + 1
    
    Faq.create( {
        :answer => Faker::Lorem.paragraph,
        :question => Faker::Lorem.paragraph,
        :position => position,
        :faq_category_id => faq_category_id
    } )
end

User.all.each do | user |
    
    unless user.manuscripts.any?
        manuscript = Manuscript.create(
            :description => Faker::Lorem.paragraph,
            :rating_id => Rating.offset( rand( Rating.count ) ).first.id,
            :title => Faker::Lorem.words(3).join(' '),
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
end

user = User.find_by( { :email => 'testuser@example.com' } )

difference = 100 - user.word_counts.where( 'created_at < ?', 100.days.ago ).count

( difference > 0 ? difference : 0 ).times do
    
    manuscript = user.manuscripts.sample
    expected_words_per_day = manuscript.inkling.word_rate_goal / manuscript.inkling.word_rate_goal_basis
    
    WordCount.create!(
        :completed_at => rand( 100.days ).seconds.ago,
        :manuscript_id => manuscript.id,
        :user_id => user.id,
        :words => rand( 3 * expected_words_per_day ) - expected_words_per_day
    )
end
