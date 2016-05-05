Rails.application.routes.draw do

    root :to => 'core_pages#home'
    
    namespace :admin do
    
        root :to => 'core_pages#dashboard'
        
        get    '/signin',  :to => 'sessions#new'
        post   '/signin',  :to => 'sessions#create'
        delete '/signout', :to => 'sessions#destroy', :as => 'signout'
        
        resources :news_reports, :only => [ :create, :destroy, :edit, :index, :new, :update ]
        resources :faqs
    end
    
    resources :account_activations, :only => [ :create, :edit, :new ]
    resources :feedback, :only => [ :destroy ]
    resources :forums, :only => [ :index, :show ] do
        resources :conversations, :only => [ :destroy, :show ] do
            resources :comments, :only => [ :create, :destroy ]
        end
    end
    resources :friendships, :only => [ :create, :destroy, :update ]
    # sort and select are section methods, but are used on views that belong
    # to the manuscripts controller. putting them under the manuscripts 
    # resources keeps the relevant manuscript id in params as :manuscript_id.
    resources :manuscripts do
        patch '/section/:id/rename',         :to => 'sections#rename',            :as => 'section_rename'
        patch '/sections/sort',              :to => 'sections#sort',              :as => 'section_sort'
        get   '/sections/select_for_writer', :to => 'sections#select_for_writer', :as => 'section_select_for_writer'
        get   '/sections/select_for_reader', :to => 'sections#select_for_reader', :as => 'section_select_for_reader'
        post  '/feedback/',                  :to => 'feedback#create',            :as => 'feedback_index'
    end
    resources :password_resets, :only => [ :create, :edit, :new, :update ]
    resources :posts, :only => [ :create, :destroy ]
    resources :sections, :only => [ :create, :destroy, :update ]
    resources :users
    
    scope :path => '/forums' do
        resources :conversations, :only => [ :create, :new ]
    end

    get '/about', :to => 'core_pages#about', :as => 'about'
    
    get '/users/:id/social',            :to => 'users#social',      :as => 'user_social' 
    get '/users/:id/manuscripts',       :to => 'users#manuscripts', :as => 'user_manuscripts'
    
    get '/manuscripts/:id/contents', :to => 'manuscripts#contents', :as => 'manuscript_contents'
    get '/manuscripts/:id/write',    :to => 'manuscripts#write',    :as => 'manuscript_write'
    get '/manuscripts/:id/read',     :to => 'manuscripts#read',     :as => 'manuscript_read'
    get '/manuscripts/:id/feedback', :to => 'manuscripts#feedback', :as => 'manuscript_feedback'
    
    get '/help',                 :to => 'help_pages#help_center',     :as => 'help'
    get '/help/contact',         :to => 'help_pages#contact',         :as => 'contact'
    get '/help/faq',             :to => 'help_pages#faq',             :as => 'faq'
    get '/help/getting_started', :to => 'help_pages#getting_started', :as => 'getting_started'
    
    get    '/signin',  :to => 'sessions#new'
    post   '/signin',  :to => 'sessions#create'
    delete '/signout', :to => 'sessions#destroy', :as => 'signout'
    
    get '/shared/squire_ui.html', :to => 'application#squire_ui', :as => 'squire_ui'
end
