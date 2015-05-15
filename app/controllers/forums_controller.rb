class ForumsController < ApplicationController

    layout 'default.html'

    # display the forums index page.
    def index
        @forums = Forum.all
    end
    
    # display the show page for a forum.
    def show
        @forum = Forum.find( params[ :id ] )
        @conversations = @forum.conversations.all
    end
end
