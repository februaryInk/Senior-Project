Rails.application.routes.draw do

    root :to => 'core_pages#home'

    get '/about', :to => 'core_pages#about', :as => 'about'
end
