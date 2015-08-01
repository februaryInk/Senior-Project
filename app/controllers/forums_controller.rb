class ForumsController < DefaultNamespaceController

    # display the forums index page.
    def index
        community_forums = Forum.community_forums
        reading_forums = Forum.reading_forums
        writing_forums = Forum.writing_forums
        
        @forums =
            { 'Community' => community_forums,
              'Reading' => reading_forums,
              'Writing' => writing_forums }
            
    end
    
    # display the show page for a forum.
    def show
        @forum = Forum.find( params[ :id ] )
        @conversations = @forum.conversations.all
    end
end
