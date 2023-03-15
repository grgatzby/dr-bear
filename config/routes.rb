Rails.application.routes.draw do
  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
  post "multi_category", to: "categories#multishow"
  resources :categories, only: [:index, :show, :create]
  resources :results, only: [:index, :show, :create]
  resources :quizzes, only: [:show, :new, :create]
  root to: "pages#home"

  get "about", to: "pages#about"
  get "learn", to: "pages#learn"
  get "shop", to: "pages#shop"
  # get "results", to: "pages#home"

  get "results/:id/basket", to: "results#basket", as: "basket"
  patch "results/:id", to: "results#update"
end
