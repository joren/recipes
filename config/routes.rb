Rails.application.routes.draw do
  root 'recipes#index'
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"

  resources :recipes
  resources :sessions, only: :create
end
