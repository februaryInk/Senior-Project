module ForumsHelper

    def forums_index_title
    
        "#{ site_name } Forums"
    end
    
    def forums_show_title( forum )
    
        "#{ forum.name }"
    end
end
