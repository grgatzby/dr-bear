Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "results", to: "pages#home"

  get "about", to: "pages#about"
  get "learn", to: "pages#learn"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
  resources :categories, only: [:index, :show, :create]

  resources :results, only: [:show]
end
