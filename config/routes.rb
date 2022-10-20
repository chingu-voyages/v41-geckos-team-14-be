Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  post '/api/login', to: 'sessions#login'
  post '/api/signup', to: 'sessions#signup'

  get    'api/todo_items'          => 'todo_items#index'
  post   'api/todo_items'          => 'todo_items#create'
  patch  'api/todo_items/:id'      => 'todo_items#update'
  put    'api/todo_items/:id'      => 'todo_items#update'
  delete 'api/todo_items/:id'      => 'todo_items#destroy'
end
