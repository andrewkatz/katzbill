Rails.application.routes.draw do
  devise_for :users

  resources :bills, only: [:index, :create, :new]

  post 'bills/pay/:bill_id', to: 'bills#pay'

  root 'bills#index'
end
