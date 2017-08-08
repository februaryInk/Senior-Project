class Forum < ApplicationRecord

    include CallableByName

    # ASSOCIATIONS

    belongs_to :category, :class_name => 'ForumCategory', :foreign_key => 'forum_category_id'
    
    has_many :conversations
    
    # SCOPES
    
    scope :community_forums, -> { Forum.where( 'forum_category_id = ?', ForumCategory.called( 'Community' ).id ) }
    scope :reading_forums, -> { Forum.where( 'forum_category_id = ?', ForumCategory.called( 'Reading' ).id ) }
    scope :writing_forums, -> { Forum.where( 'forum_category_id = ?', ForumCategory.called( 'Writing' ).id ) }
end
