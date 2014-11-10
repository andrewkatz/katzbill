Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  resources :bills, only: [:index, :create, :new]

  get 'bills/pay/:bill_id', to: 'bills#pay'
  get 'bills/paid/:bill_id', to: 'bills#paid'

  root 'bills#index'
end
