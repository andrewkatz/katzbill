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

  get 'calendar/:token(.:format)', to: 'calendars#show', as: :calendar

  root 'home#index'
end
