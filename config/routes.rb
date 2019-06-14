Rails.application.routes.draw do
  devise_for :users, skip: [:sessions], controllers: {
    registrations: 'users/registrations',
    :omniauth_callbacks => "users/omniauth_callbacks"
  }
  devise_scope :user do
    get '/login', to: 'devise/sessions#new', as: :new_user_session
    post '/login', to: 'devise/sessions#create', as: :user_session
    get '/logout', to: 'devise/sessions#destroy', as: :destroy_user_session
  end
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
  # get '/signup', to: 'users#new'
  scope '/admin' do
    resources :admin_geofences, :blacklists, :dumpsters, :geofences
  end
  get '/admin', to: 'admin#index'
  # get '/admin/blacklist', to: 'admin#blacklist'
  # get '/admin/dumpster', to: 'dumpsters#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/tos', to: 'welcome#tos'
  get '/aup', to: 'welcome#aup'
  post '/new_admin', to: 'users#create_admin', as: :create_admin
  get '/new_admin', to: 'users#new_admin', as: :new_admin
  get '/following', to: 'posts#following', as: :following
  get '/search', to: 'search#index'
end
