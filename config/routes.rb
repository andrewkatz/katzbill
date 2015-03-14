Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  resources :bills, only: [:index, :create, :new, :destroy] do
    member do
      post 'pay'
    end
  end

  resources :paychecks, only: [:index, :create, :new, :destroy] do
    member do
      post 'pay'
    end
  end

  get 'calendar/:calendar_type/:token(.:format)', to: 'calendars#show', as: :calendar
  get 'calendar/:token(.:format)', to: 'calendars#show'

  root 'home#index'
end
