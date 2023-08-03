Rails.application.routes.draw do
  root 'gossip#index'

  resources :gossip do
    resources :comments, shallow: true do
      resources :comments, defaults: { commentable: 'comment' }
      resources :likes, only: [:create, :destroy], defaults: { likeable: 'comment' }
    end
    resources :likes, only: [:create, :destroy], defaults: { likeable: 'gossip' }
  end

  resources :sessions, only: [:new, :create, :destroy]
  resources :tags

  resources :users
  resources :cities, only: :show

  get '/contacts', to: 'static#contacts'
  get '/team', to: 'static#team'
  get '/welcome/:name', to: 'static#welcome'

  # Defines the root path route ("/")
  # root "articles#index"
end
