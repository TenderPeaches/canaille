Rails.application.routes.draw do
  # sign_up, sign_in, sign out, etc.
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  root "users#landing"

  # /service_providers
  resources :service_providers do
    member do 
      post :ask_quote, as: :ask_service_offer_quote
      # post :offer_help, as: :offer_help
    end
    collection do
      get :portal, as: :portal
    end
  end

  # /users 
  resources :users do
    # users form actions 
    post :is_service_provider, on: :collection
    post :is_not_service_provider, on: :collection
    # user/[:user_id]/service_providers (new/create/index)
    resources :service_providers, shallow: true
    # user/[:user_id]/service_provider_accesses (new/create/index)
    resources :user_service_provider_accesses, as: :service_provider_accesses, shallow: true
  end 
=begin
  # /service_request
  resource :service_request do
      # /service_request/use_client_address
      get :use_client_address, as: :use_client_address
      # /service_request/use_unique_address
      get :use_unique_address, as: :use_unique_address
  end 
=end
  resources :service_requests do 
    collection do 
      get :use_client_address, as: :use_client_address
      get :use_unique_address, as: :use_unique_address
    end
  end

  scope "/portal" do
    get :client, to: "clients#portal", as: :client_portal
    get :service_provider, to: "service_provider#portal", as: :service_provider_portal
  end

  # /clients
  resources :clients do 
    member do
      get :portal, as: :portal
    end
    # clients/[:client_id]/service_requests (new/create/index)
    #resources :service_requests, shallow: true
    # clients/[:client_id]/service_quotes (new/create/index)
    resources :service_quotes, shallow: true
  end

  # /cities
  resources :cities

  # /coordinates
  resources :coordinates do
    # coordinate form actions
    # /coordinates/use_new_city
    post :use_new_city, on: :collection
    # /coordinates/use_existing_city
    post :use_existing_city, on: :collection
  end 

  # /service_categories
  resources :service_categories do
    member do 
      # picker actions
      get :pick, as: :pick
    end
    # /service_categories/[:service_category_id]/services
    resources :services
  end

  # /transportation_services
  resources :transportation_services
end
