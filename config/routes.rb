Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :categories, only: [:index, :show, :create]

  resources :results, only: [:show]
  get "results", to: "pages#home"
  get "results/:id/basket", to: "results#basket", as: "basket"
  patch "results/:id", to: "results#update"
end
