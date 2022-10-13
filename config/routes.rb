Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  post '/api/login', to: 'sessions#login'
  post '/api/signup', to: 'sessions#signup'
end
