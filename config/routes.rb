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
  
  resources :service_requests do 
    collection do 
      get :use_client_address, as: :use_client_address
      get :use_unique_address, as: :use_unique_address
      post :use_new_city, as: :use_new_city
      post :use_existing_city, as: :use_existing_city
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
  end

  scope module: :clients do
    get "client/service_request/:id", to: "service_requests#show", as: :client_service_request
    get "client/service_request/:id/service_providers", to: "service_requests#find_providers", as: :find_service_request_providers
    post "client/service_request/:id/cancel", to: "service_requests#cancel", as: :cancel_service_request
    post "client/service_request/:id/activate", to: "service_requests#activate", as: :activate_service_request
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
