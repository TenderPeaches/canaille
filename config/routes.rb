Rails.application.routes.draw do
  root "application#index"
  
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :users
  resources :service_requests
  resources :service_offers
  resources :service_quotes
  resources :transportation_services
end
