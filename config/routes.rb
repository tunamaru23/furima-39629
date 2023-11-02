Rails.application.routes.draw do
  devise_for :users
  #root to: 'devise/registrations#new'
  root to: 'items#index'
  resources :items, only:[:index, :new, :create,:show, :destroy]


end
