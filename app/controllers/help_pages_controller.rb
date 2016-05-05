class HelpPagesController < DefaultNamespaceController

    layout( 'help_pages.html.haml' )

    # display the contact page.
    def contact
    end

    # display the FAQ page.
    def faq
        @faqs = Faq.all
    end

    # display the getting started page.
    def getting_started
    end

    # display the help center page.
    def help_center
    end
end
