Rails.application.routes.draw do
  root 'posts#index'
  resources :users, only: [:edit,:update]
  resources :posts do
    collection do
      get 'search'
    end
  end
  devise_for :users,skip: :all
  devise_scope :user do
    get 'signup' => 'devise/registrations#new', as: :new_user_registration
    post 'signup' => 'devise/registrations#create', as: :user_registration
    get 'login' => 'devise/sessions#new', as: :new_user_session
    post 'login' => 'devise/sessions#create', as: :user_session
    delete 'logout' => 'devise/sessions#destroy', as: :destroy_user_session
    delete 'user' => 'devise/registrations#destroy', as: :destroy_user_registration
  end
  

end
