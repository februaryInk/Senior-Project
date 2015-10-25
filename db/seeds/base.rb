forum_categories = [ 
    'Community',
    'Reading',
    'Writing' 
]

forum_categories.each do | name |
    
    ForumCategory.create( :name => name )
end
      
community_forums = [ 
    'Introduce Yourself', 
    'Questions and Answers', 
    'General Talk',
    'Role Playing' 
]

community_forums.each do | name |

    Forum.create( 
        :forum_category_id => ForumCategory.called( 'Community' ).id,
        :name => name
    )
end
      
reading_forums = [ 
    'Authors',
    'Good Books',
    'Stories on Inklings'
]
      
reading_forums.each do | name |
    
    Forum.create(
        :forum_category_id => ForumCategory.called( 'Reading' ).id,
        :name => name
    )
end
      
writing_forums = [
    'Advice',
    'Characters',
    'Grammar and Form',
    'Ideas Exchange',
    'Playing with Plot',
    'Revising and Polishing'
]

writing_forums.each do | name |
    
    Forum.create(
        :forum_category_id => ForumCategory.called( 'Writing' ).id,
        :name => name )
end
      
genres = [ 
    'Adventure', 
    'Action', 
    'Fantasy', 
    'Fiction', 
    'Historical', 
    'Horror', 
    'Literary', 
    'Mystery', 
    'Non-Fiction', 
    'Romance', 
    'Paranormal', 
    'Western' 
]

genres.each do | name |
    
    Genre.find_or_create_by( :name => name )
end    
    
ratings = [ 
    'Friendly',
    'Mild',
    'Candid',
    'Intense',
    'Explicit'
]

ratings.each do | name |

    Rating.find_or_create_by( :name => name )
end
      
FriendshipStatus.create( :name => 'Accepted' )
FriendshipStatus.create( :name => 'Pending' )
FriendshipStatus.create( :name => 'Waiting' )

UserRole.create( :name => 'Admin' )
UserRole.create( :name => 'Standard' )
