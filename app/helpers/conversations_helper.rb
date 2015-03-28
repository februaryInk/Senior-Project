module ConversationsHelper
    def conversations_new_title
        'New Conversation'
    end
    
    def conversations_show_title( conversation )
        "#{ conversation.name }"
    end
end
