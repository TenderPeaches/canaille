Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  root "application#index"

  resources :users do
    post :is_service_provider, on: :collection
    post :is_not_service_provider, on: :collection
  end
  resources :service_requests 
  resources :cities
  resource :service_request do
    member do 
      get :use_client_address, as: :use_client_address
      get :use_unique_address, as: :use_unique_address
    end
  end 
  resources :clients do 
    resources :service_requests
    resources :service_quotes
  end

  resources :coordinates do
    post :use_new_city, on: :collection
    post :use_existing_city, on: :collection
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
