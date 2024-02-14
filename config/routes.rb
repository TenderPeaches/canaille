Rails.application.routes.draw do
  # sign_up, sign_in, sign out, etc.
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

  resource :home, only: %i[ index ]

  # /service_providers
  resources :service_providers do
    resources :service_offers, controller: "service_providers/service_offers"
    resources :user_service_provider_accesses, as: :accesses
    resources :quote_requests, only: %i[ show index ]
    resource :quote_history, controller: "service_providers/quote_history", only: %i[ index ]
  end


  # /users 
  resources :users do
    # users form actions #? turn into resource somehow? 
    post :is_service_provider, on: :collection
    post :is_not_service_provider, on: :collection
  end 

  resources :user_service_provider_accesses
  #?
  scope :user do 
    get :service_providers, controller: :users, action: :service_providers, as: :user_service_providers
  end
  
  resources :service_requests do  # for when a client interacts with a service_request they have made
    collection do 
      get :use_client_address, as: :use_client_address
      get :use_unique_address, as: :use_unique_address
      post :use_new_city, as: :use_new_city
      post :use_existing_city, as: :use_existing_city
    end
  end

  # todo resouces :prospective_service_requests # for when a service_provider interacts with a service_request to consider making a quote > unless this branches off at the controller? 

  resources :service_provider_portals, only: %i[ show ]
  resources :client_portals, only: %i[ show ]

  # /clients
  resources :clients do 
    resources :quote_requests, only: %i[ new create index ]
    member do
      #! to be obsoleted x3
      get :edit_coordinate, to: "clients#edit_coordinate", as: :edit_coordinate
      get :cancel_edit_coordinate, to: "clients#cancel_edit_coordinate", as: :cancel_edit_coordinate
      patch :edit_coordinate, to: "clients#update_coordinate", as: :update_coordinate
    end
  end

  namespace :client do
    resource :coordinate, only: %i[new create edit update destroy]
    # resources :service_requests
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

  root "home#index"

  # Developement resources
  if Rails.env.development?
    resources :design_systems, only: [ :index ]
  end
end
