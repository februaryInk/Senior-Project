module ApplicationHelper

    # get a user's globally recognized avatar, hosted at gravatar.com under their
    # username.
    def gravatar_for( user )
        gravatar_id = Digest::MD5::hexdigest( user.email.downcase )
        gravatar_url = "https://secure.gravatar.com/avatar/#{ gravatar_id }"
        image_tag( gravatar_url, :alt => user.username, :class => 'gravatar' )
    end

    # use site_name for all instances, so that it is trivial to change it.
    def site_name
        
        'Inklings'
    end
end
