Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  get 'posts/index'
  root 'posts#index'
  # get '/post', to: 'welcome#post' # Temporal, in future specify post id

  get '/post/create_post', to: 'posts#create_post'
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
  get '/login', to: 'welcome#login' # TODO: to sessions#new
  get '/admin', to: 'admin#page'
  get '/admin/blacklist', to: 'admin#blacklist'
  get '/admin/dumpster', to: 'dumpsters#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
