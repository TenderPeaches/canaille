Rails.application.routes.draw do
  root "application#index"

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :users
  resources :service_requests
  scope '/user' do 
    resource :client
    resources :user_service_provider_accesses
  end
  resources :clients do 
    resources :service_requests
    resources :service_quotes
  end

  resources :service_categories do
    member do 
      get :pick, as: :pick
    end
    resources :services
    resources :transportation_services
  end

  resources :service_providers do
    resources :user_service_provider_accesses
    resources :service_quotes
    resources :service_offers
  end
end
