Rails.application.routes.draw do
  devise_for :users
  root to: 'groups#index'
  resources :users
  resources :splash, only: [:index]
  resources :groups
end
