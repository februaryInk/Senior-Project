module ApplicationHelper

    include FormsHelper
    
    # adjust the date format according to how recent a datetime was.
    def formatted_datetime( datetime )
        
        return '' unless datetime.present?
        
        if datetime.year != Time.zone.now.year
            l( datetime.in_time_zone, :format => :month_day_year )
        elsif datetime.in_time_zone < DateTime.now.in_time_zone( Time.zone ).beginning_of_day
            l( datetime.in_time_zone, :format => :month_day )
        else
            l( datetime.in_time_zone, :format => :time_only )
        end
    end
    
    # adjust the date format according to how recent a datetime was.
    def formatted_datetime_in_words( datetime )
        
        return '' unless datetime.present?
        
        if datetime.year != Time.zone.now.year
            l( datetime.in_time_zone, :format => :month_day_year )
        elsif datetime.in_time_zone < DateTime.now.in_time_zone( Time.zone ).beginning_of_day
            "on #{l( datetime.in_time_zone, :format => :month_day )}"
        else
            "at #{l( datetime.in_time_zone, :format => :time_only )}"
        end
    end

    # get a user's globally recognized avatar, hosted at gravatar.com under their
    # username.
    def gravatar_for( user )
    
        gravatar_id = Digest::MD5::hexdigest( user.email.downcase )
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
        image_tag( gravatar_url, :alt => user.username, :class => 'gravatar' )
    end
    
    # determine the namespace of the current controller.
    def namespace
    
        controller.class.parent.name == 'Object' ? '' : controller.class.parent.name.underscore.gsub( '_', '-' )
    end
    
    # define a class for the page body by joining the names of the namespace, 
    # controller, and action names, after removing any empty values.
    def page_body_class
    
        namespace_called = namespace
        controller_called = controller_name.underscore.gsub( '_', '-' )
        action_called = action_name.gsub( '_', '-' )

        ( [ namespace_called, controller_called, action_called ].reject { | name | name.blank? } ).join( '-' )
    end

    # use site_name for all instances, so that it is trivial to change it.
    def site_name
        
        'Inklings'
    end
end
