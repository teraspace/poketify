Rails.application.routes.draw do
  get 'hello_world', to: 'hello_world#index'
  get 'hello/world'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :pokemons

  namespace :auth, path: '', as: '' do
    resources :users, only: [ :new, :create ]
    resources :sessions, only: [ :new, :create ]
  end

  get '/permanent_error', to: 'errors#permanent_error'
  get '/temporal_error', to: 'errors#temporal_error'
end
