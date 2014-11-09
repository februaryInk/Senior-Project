class CorePagesController < ApplicationController
    def about
    end

    def home
        @user = User.new
    end
end
