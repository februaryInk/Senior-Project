class ApplicationController < ActionController::Base

    protect_from_forgery with: :exception
    
    around_action :set_time_zone
    
    # set the time zone for the current action based on (in order of priority)
    # the user's set time zone, the time-zone cookie, or the default of EST.
    def set_time_zone( &block )
        if signed_in? && current_user.time_zone.present?
            time_zone = current_user.time_zone
        else
           time_zone = cookies[ 'time-zone' ]
        end
        
        time_zone = 'EST' unless defined?( time_zone ) && time_zone.present?
        
        Time.use_zone( time_zone, &block )
    end
    
    # render the HTML that forms the UI for Squire. called by squire_ui.js.
    def squire_ui
        render( 'shared/squire_ui.html', { :layout => nil } )
    end
end
