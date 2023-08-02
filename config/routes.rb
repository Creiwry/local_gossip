Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'gossip#index'

  resources :gossip do
    resources :comments do
      resources :comments
    end
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
