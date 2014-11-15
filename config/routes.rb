Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  resources :bills, only: [:index, :create, :new]

  get 'calendar/:token(.:format)', to: 'calendars#show', as: :calendar
  post 'bills/pay/:bill_id', to: 'bills#pay'

  root 'bills#index'
end
