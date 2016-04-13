Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }, skip: [:sessions]
  resources :users, only: [:show]

  root 'home#index'


end
