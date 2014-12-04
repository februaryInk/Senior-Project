module UsersHelper
    
    def gravatar_for( user )
        gravatar_id = Digest::MD5::hexdigest( user.email.downcase )
        gravatar_url = "https://secure.gravatar.com/avatar/#{ gravatar_id }"
        image_tag( gravatar_url, :alt => user.username, :class => 'gravatar' )
    end

    def users_index_title
    
        "#{ site_name } Members"
    end

    def users_new_title
    
        "#{ site_name } Signup"
    end
    
    def users_show_title
    
        'Account Overview'
    end
end
