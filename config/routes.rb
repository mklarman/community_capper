Rails.application.routes.draw do

	resources :matchups
  resources :picks
  

	get "users/profile" => "welcome#users_show"
  get "matchup/list" => "matchups#matchups_list"
  get "about/welcome" => "welcome#about"
	

  
  	

  	devise_for :users, :controllers => { :registrations => 'users/registrations' }
	    devise_scope :user do
    		
        authenticated :user do
      		root :to => 'welcome#users_show', as: :authenticated_root
    		end
   	 	  
        unauthenticated :user do
      		
          root :to => 'devise/registrations#new', as: :unauthenticated_root
    		
        end
      
    end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    end
