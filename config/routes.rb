NiftyGifter::Application.routes.draw do 

  resources :token, :only => [:create, :destroy]

  resources :events do 
    resources :recipients, :controller => "events"
  end

  resources :recipients do 
    get 'checkout' => 'recipients#checkout'
  end


  resources :scans do
    resources :recipients, :controller => "scans", :except => [:show] 
  end
  match '/events/new/recipient/:recipient_id' => 'events#new', :via => 'get', :as => :new_event_with_recipient
  match '/scans/find/:upc' => 'scans#find', :via => 'get'
  match '/scans/:scan_id/recipients/:id(.:format)' => 'scans#update', :via => 'get'




  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :users,:controllers => { :omniauth_callbacks => "users/omniauth_callbacks", :registrations => "registrations" }

  devise_scope :user do    
    get '/users/auth/:provider' => 'users/omniauth_callbacks#passthru'
    match 'auth/:provider/callback', to: 'users/omniauth_callbacks#facebook'
    get '/login' => 'devise/sessions#new', :as => :app_root
    get '/logout' => 'devise/sessions#destroy'
  end

  root :to => "home#index"

end
