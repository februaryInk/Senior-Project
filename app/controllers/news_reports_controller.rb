class NewsReportsController < ApplicationController
    include AuthorizationFilters
    
    before_action :signed_in_user, :only => [ :destroy, :edit, :index, :update ]
    before_action :admin_user, :only => [ :destroy, :index ]

    def create
        @report = current_user.news_reports.build( news_report_params )
        if @report.save
            redirect_to root_url
        end
    end
    
    def destroy
        @report = NewsReport.find_by( params[ :id ] )
        @report.destroy
        redirect_to root_url
    end
    
    private
        
        def news_report_params
            params.require( :news_report ).permit( :content, :title, :user_id )
        end
end
