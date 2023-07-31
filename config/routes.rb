Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'gossip#index'

  get '/gossip/:id', to: 'gossip#show', as: 'gossip'
  get '/users/:id', to: 'users#show', as: 'user'
  get '/contacts', to: 'static#contacts'
  get '/team', to: 'static#team'
  get '/welcome/:name', to: 'static#welcome'

  # Defines the root path route ("/")
  # root "articles#index"
end
