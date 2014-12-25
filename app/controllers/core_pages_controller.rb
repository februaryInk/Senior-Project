class CorePagesController < ApplicationController
    layout 'default.html'
    
    def about
    end

    def home
        @user = User.new
        if signed_in? && current_user.admin?
            @news_report = current_user.news_reports.new
        end
        @news_reports = NewsReport.all
    end
end
