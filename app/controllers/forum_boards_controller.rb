class ForumBoardsController < ApplicationController
    layout 'default.html'

    def index
        @forum_boards = ForumBoard.all
    end
    
    def show
        @board = ForumBoard.find( params[ :id ] )
        @threads = @board.forum_threads.all
    end
end
