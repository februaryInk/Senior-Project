class ForumsController < ApplicationController
    layout 'default.html'

    def index
        @forums = Forum.all
    end
    
    def show
        @forum = Forum.find( params[ :id ] )
        @conversations = @forum.conversations.all
    end
end
