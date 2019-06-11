Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    :omniauth_callbacks => "users/omniauth_callbacks"
  }
  get 'posts/index'
  root 'posts#index'
  # get '/post', to: 'welcome#post' # Temporal, in future specify post id

  resources :user_profiles
  get 'profile', to: 'users#show'
  resources :follow_users
  resources :votes
  resources :shared_files
  resources :file_types
  resources :user_shareds
  resources :user_statuses
  resources :follow_posts
  resources :comments
  resources :posts do
    resources :comments
    resources :post_flags, as: 'flags'
  end
  get '/map', to: 'posts#map'
  resources :users
  get '/signup', to: 'users#new'
  get '/login', to: 'welcome#login' # TODO: to sessions#new
  scope '/admin' do
    resources :admin_geofences, :blacklists, :dumpsters, :geofences
  end
  get '/admin', to: 'admin#index'
  # get '/admin/blacklist', to: 'admin#blacklist'
  # get '/admin/dumpster', to: 'dumpsters#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/tos', to: 'welcome#tos'
  get '/aup', to: 'welcome#aup'
end
