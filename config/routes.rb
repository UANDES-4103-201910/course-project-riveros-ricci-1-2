Rails.application.routes.draw do
  get 'welcome/index'
  root 'welcome#index'
  get '/post', to: 'welcome#post' # Temporal, in future specify post id
  resources :post_flags
  resources :admin_geofences
  resources :user_profiles
  resources :follow_users
  resources :dumpsters
  resources :blacklists
  resources :votes
  resources :shared_files
  resources :file_types
  resources :user_shareds
  resources :user_statuses
  resources :follow_posts
  resources :comments
  resources :posts
  resources :users
  get '/signup', to: 'users#new'
  get '/admin', to: 'admin#page'
  get '/admin/blacklist', to: 'admin#blacklist'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
