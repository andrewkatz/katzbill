Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  resources :payments, except: [:show] do
    member do
      post 'pay'
    end
  end

  get 'calendar/:calendar_type/:token(.:format)', to: 'calendars#show', as: :calendar
  get 'calendar/:token(.:format)', to: 'calendars#show'

  root 'home#index'
end
