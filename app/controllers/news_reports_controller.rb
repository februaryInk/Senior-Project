class NewsReportsController < ApplicationController

    layout 'default'
    include AuthorizationFilters
    
    # BEFORE ACTIONS
    
    before_action :signed_in_user
    before_action :admin_user

    # create a new news_report.
    def create
        @news_report = current_user.news_reports.build( news_report_params )
        if @news_report.save
            redirect_to root_url
        else
            render 'core_pages/home'
        end
    end
    
    # delete a news report.
    def destroy
        news_report = NewsReport.find( params[ :id ] )
        news_report.destroy
        redirect_to root_url
    end
    
    def edit
        @news_report = NewsReport.find( params[ :id ] )
    end
    
    def update
        @news_report = NewsReport.find( params[ :id ] )
        if @news_report.update_attributes( news_report_params )
            flash[ :success ] = 'News report has been updated.'
            redirect_to root_path
        else
            render 'new'
        end
    end
    
    private
        
        def news_report_params
            params.require( :news_report ).permit( :content, :title, :user_id )
        end
end
