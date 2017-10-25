Rails.application.routes.draw do

  get 'relationships/create'
  get 'relationships/destroy'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
    devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  resources :topics do
    resources :comments
  end
  
  resources :conversations do
    resources :messages
  end
  
  resources :users,         only: [:index,  :show]
  resources :relationships, only: [:create, :destroy]
  
  root 'top#index'
end
