Rails.application.routes.draw do
  root 'posts#index'
  devise_for :users
  resources :users, only: [:edit,:update]
  resources :posts, only: [:create]
end
