Rails.application.routes.draw do
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"

  resources :products
  get 'demo_partials/new'
  get 'demo_partials/edit'
  get 'static_pages/home'
  get 'static_pages/help'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  resources :users, only: %i(show)
  # Defines the root path route ("/")
  # root "articles#index"
end
