Rails.application.routes.draw do
  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
  resources :categories, only: [:index, :show, :create]

  resources :results, only: [:show]

  get "results", to: "pages#home"

  get "about", to: "pages#about"
  get "learn", to: "pages#learn"
  get "results", to: "pages#home"
  get "results/:id/basket", to: "results#basket", as: "basket"
  patch "results/:id", to: "results#update"

end
