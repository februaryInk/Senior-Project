class NewsReportsController < DefaultNamespaceController
    
    # BEFORE ACTIONS
    
    before_action :signed_in_user
    before_action :admin_user

    # create a new news_report.
    def create
        @news_report = current_user.news_reports.build( news_report_params )
        respond_to do | format |
            if @news_report.save
                @saved = true
                format.html { redirect_to root_path }
            else
                @saved = false
            end
            format.js { render layout: false, content_type: 'text/javascript' }
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
