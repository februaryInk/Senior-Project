class NewsReportsController < ApplicationController

    include AuthorizationFilters
    
    # BEFORE ACTIONS
    
    before_action :signed_in_user, :only => [ :create, :destroy ]
    before_action :admin_user, :only => [ :create, :destroy ]

    # create a new news_report.
    def create
        @report = current_user.news_reports.build( news_report_params )
        if @report.save
            redirect_to root_url
        end
    end
    
    # delete a news report.
    def destroy
        @report = NewsReport.find( params[ :id ] )
        @report.destroy
        redirect_to root_url
    end
    
    private
        
        def news_report_params
            params.require( :news_report ).permit( :content, :title, :user_id )
        end
end
