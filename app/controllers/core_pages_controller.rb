class CorePagesController < ApplicationController
    layout 'default.html'
    
    def about
    end

    def home
        @user = User.new
    end
end
