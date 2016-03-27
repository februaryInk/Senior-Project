forum_categories = [ 
    'Community',
    'Reading',
    'Writing' 
]

forum_categories.each do | name |

    ForumCategory.create( :name => name )
end
      
forums = {
    'Community' => [
        'Introduce Yourself', 
        'Questions and Answers', 
        'General Talk',
        'Role Playing'
    ],
    'Reading' => [
        'Authors',
        'Good Books',
        'Community Stories'
    ],
    'Writing' => [
        'Advice',
        'Characters',
        'Grammar and Form',
        'Ideas Exchange',
        'Playing with Plot',
        'Revising and Polishing'
    ]
}

forums.each do | category, names |

    names.each do | name |
    
        Forum.create(
            :forum_category_id => ForumCategory.called( category ).id,
            :name => name
        )
    end
end
      
genres = [ 
    'Adventure', 
    'Action', 
    'Comedy', 
    'Fantasy', 
    'Fiction', 
    'Gothic', 
    'Historical', 
    'Horror', 
    'Literary', 
    'Mystery', 
    'Non-Fiction', 
    'Religious', 
    'Romance', 
    'Paranormal', 
    'Science Fiction', 
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
