Rails.application.routes.draw do
  root 'recipes#index'
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"

  resources :dropped_links, only: [:create]
  resources :recipes
  resources :sessions, only: :create
end
