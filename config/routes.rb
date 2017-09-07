Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { registrations: 'registrations' }

  resources :payments do
    member do
      post 'pay'
    end
  end

  get 'calendar/:calendar_type/:token(.:format)', to: 'calendars#show', as: :calendar
  get 'calendar/:token(.:format)', to: 'calendars#show'
  get 'me', to: 'users#show'

  get 'dashboard', to: 'dashboard#index'
  root 'home#index'
end
