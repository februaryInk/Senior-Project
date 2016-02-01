class Admin::NewsReportsController < AdminNamespaceController

    # BEFORE ACTIONS
    
    before_action :signed_in_admin

    def create
        @news_report = current_admin_user.news_reports.build( news_report_params )
        if @news_report.save
            flash[ :success ] = 'Report successfully created.'
            redirect_to( admin_news_reports_path )
        else
            render( 'new.html.haml' )
        end
    end
    
    def destroy
        news_report = NewsReport.find( params[ :id ] )
        news_report.destroy
        flash[ :success ] = 'Report successfully destroyed.'
        redirect_to( admin_news_reports_path )
    end
    
    def edit
        @news_report = NewsReport.find( params[ :id ] )
    end
    
    def index
        @news_reports = NewsReport.all
    end
    
    def new
        @news_report = NewsReport.new
    end
    
    def update
        @news_report = NewsReport.find( params[ :id ] )
        if @news_report.update_attributes( news_report_params )
            flash[ :success ] = 'News report has been updated.'
            redirect_to( admin_news_reports_path )
        else
            render( 'edit.html.haml' )
        end
    end
    
    private
        
        def news_report_params
            params.require( :news_report ).permit( :content, :title )
        end
end
