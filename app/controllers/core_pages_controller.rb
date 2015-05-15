class CorePagesController < ApplicationController

    layout 'default.html'
    
    # display the about page.
    def about
    end

    # display the home page, adjusted to the current_user.
    def home
        if signed_in?
            if current_user.manuscripts.any?
                @working_on = current_user.manuscripts.order( :updated_at ).last
            end
            if current_user.admin?
                @news_report = current_user.news_reports.new
            end
        else
            @user = User.new
        end
        @news_reports = NewsReport.all
    end
end
