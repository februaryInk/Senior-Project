module ManuscriptsHelper
    def manuscripts_contents_title( manuscript )
        "#{ manuscript.title } Contents"
    end
    
    def manuscripts_edit_title( manuscript )
        "Edit #{ manuscript.title }"
    end
    
    def manuscripts_index_title
        "#{ site_name } Manuscript Library"
    end
    
    def manuscripts_new_title
        'Create New Manuscript'
    end
    
    def manuscripts_read_title( manuscript )
        "#{ manuscript.title }"
    end
    
    def manuscripts_show_title( manuscript )
        "#{ manuscript.title }"
    end
    
    def manuscripts_write_title( manuscript )
        "Writing #{ manuscript.title }"
    end
end
