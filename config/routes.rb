Rails.application.routes.draw do

	resources :matchups
	resources :tags
	resources :selections
  resources :teams
  resources :mlb_game_logs

	get "users/profile" => "welcome#users_show"
	get "users/search" => "welcome#user_list"
  	

  	devise_for :users, :controllers => { :registrations => 'users/registrations' }
	devise_scope :user do
  		authenticated :user do
    		root :to => 'welcome#user_list', as: :authenticated_root
  		end
 	 	unauthenticated :user do
    		root :to => 'devise/registrations#new', as: :unauthenticated_root
  		end
	end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
