forum_categories = 
    [ 'Community',
      'Reading',
      'Writing' ]

forum_categories.each do | name |
    
    ForumCategory.create( :name => name )
end
      
community_forums = 
    [ 'Introduce Yourself', 
      'Questions and Answers', 
      'General Talk',
      'Role Playing' ]

community_forums.each do | name |

    Forum.create( 
        :forum_category_id => ForumCategory.called( 'Community' ).id,
        :name => name )
end
      
reading_forums =
    [ 'Authors',
      'Good Books',
      'Stories on Inklings' ]
      
reading_forums.each do | name |
    
    Forum.create(
        :forum_category_id => ForumCategory.called( 'Reading' ).id,
        :name => name )
end
      
writing_forums = 
    [ 'Advice',
      'Characters',
      'Grammar and Form',
      'Ideas Exchange',
      'Playing with Plot',
      'Revising and Polishing' ]

writing_forums.each do | name |
    
    Forum.create(
        :forum_category_id => ForumCategory.called( 'Writing' ).id,
        :name => name )
end
      
genres =
    [ 'Adventure', 
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
      'Western' ]

genres.each do | name |
    
    Genre.create( :name => name )
end    
    
ratings =
    [ 'Friendly',
      'Mild',
      'Candid',
      'Intense',
      'Explicit' ]

ratings.each do | name |

    Rating.create( :name => name )
end
      
FriendshipStatus.create( :name => 'Accepted' )
FriendshipStatus.create( :name => 'Pending' )
FriendshipStatus.create( :name => 'Waiting' )

UserRole.create( :name => 'Admin' )
UserRole.create( :name => 'Standard' )

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