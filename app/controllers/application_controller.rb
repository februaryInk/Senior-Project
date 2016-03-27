class ApplicationController < ActionController::Base

    protect_from_forgery with: :exception
    
    # render the HTML that forms the UI for Squire. called by squire_ui.js.
    def squire_ui
        render( 'shared/squire_ui.html', { :layout => nil } )
    end
end
