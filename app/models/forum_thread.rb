class ForumThread < ActiveRecord::Base
    belongs_to :forum_board
    belongs_to :user
    
    has_many :forum_posts, :dependent => :destroy
    
    validates :forum_board_id, { :presence => true }
    validates :user_id, { :presence => true }
    validates :name, { :length => { :maximum => 140 }, :presence => true }
end
