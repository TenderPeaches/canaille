Rails.application.routes.draw do
  # sign_up, sign_in, sign out, etc.
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

  # /service_providers
  resources :service_providers do
    member do 
      #! to be obsoleted
      post :ask_quote, as: :ask_service_offer_quote
      # post :offer_help, as: :offer_help
    end
    #! to be obsoleted
    collection do
      get :portal, as: :portal
    end
    resources :service_offers
    resources :user_service_provider_accesses, as: :accesses
  end

  # todo replaces :ask_quote
  #resources :quote_requests
  # todo replaces /service_providers/portal
  #resources :service_provider_portal
  


  # /users 
  resources :users do
    # users form actions 
    post :is_service_provider, on: :collection
    post :is_not_service_provider, on: :collection
  end 

  scope :user do 
    get :service_providers, controller: :users, action: :service_providers, as: :user_service_providers
  end
  
  resources :service_requests do 
    collection do 
      get :use_client_address, as: :use_client_address
      get :use_unique_address, as: :use_unique_address
      post :use_new_city, as: :use_new_city
      post :use_existing_city, as: :use_existing_city
    end
  end

  #! to be obsoleted
  scope "/portal" do
    get :client, to: "clients#portal", as: :client_portal
    get :service_provider, to: "service_providers#portal", as: :service_provider_portal
  end

  # /clients
  resources :clients do 
    member do
      get :portal, as: :portal
      #! to be obsoleted x3
      get :edit_coordinate, to: "clients#edit_coordinate", as: :edit_coordinate
      get :cancel_edit_coordinate, to: "clients#cancel_edit_coordinate", as: :cancel_edit_coordinate
      patch :edit_coordinate, to: "clients#update_coordinate", as: :update_coordinate
    end
  end

  namespace :client do
    resource :coordinate, only: %i[new create edit update destroy]
    resources :service_requests
    resources :service_request_activations, only: %i[ new destroy ]
    resource :service_provider_search
  end

  #! to be obsoleted
  scope module: :clients do
    get "client/service_request/:id", to: "service_requests#show", as: :client_service_request
    get "client/service_request/:id/service_providers", to: "service_requests#find_providers", as: :find_service_request_providers
    post "client/service_request/:id/cancel", to: "service_requests#cancel", as: :cancel_service_request
    post "client/service_request/:id/activate", to: "service_requests#activate", as: :activate_service_request
  end

  # /service_providers
  scope :service_provider do 
    get :browse_service_requests, to: "service_providers#browse_service_requests", as: :browse_service_requests_as_service_provider
    get :quote_history, to: "service_providers#quote_history", as: :service_provider_quote_history
  end

  # /cities
  resources :cities

  # /coordinates
  #! this probably shouldn't exist, should be through the other resources
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
      # todo how to turn into resource?
      get :pick, as: :pick
    end
    # /service_categories/[:service_category_id]/services
    resources :services, only: %i[ index ]
  end

  # /transportation_services
  # todo 
  # resources :transportation_services

  root "users#landing"

  # Developement resources
  if Rails.env.development?
    resources :design_systems, only: [ :index ]
  end
end
