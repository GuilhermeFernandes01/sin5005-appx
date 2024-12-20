
Rails.application.routes.draw do
  resources :ingredients


  get "/employees", to: "employees#index"
  get "/employees/new", to: "employees#new"
  get "/employees/:id", to: "employees#show"
  get "/employees/:id/edit", to: "employees#edit"
  put "/employees/:id", to: "employees#update"
  patch "/employees/:id/fire", to: "employees#fire", as: "fire_employee"

  resources :employees, only: [
    :index,
    :show,
    :new,
    :create,
    :edit,
    :update,
    :destroy
  ]

  root "home#index"
  resources :suppliers
  resources :clientes


  # get "/products/new", to: "products#new", as: "new_product"
  # post "/products", to: "products#create"
  resources :products

  resources :cart, only: [ :index ]
  post "add_product/:product_id", to: "cart#add_product", as: "add_product_cart"
  post "calculate_freight", to: "cart#calculate_freight", as: "calculate_freight_cart"
  delete "remove_product/:product_id", to: "cart#remove_product", as: "remove_product_cart"

  resources :orders, only: [ :index, :create, :destroy ]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.

  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"

  get "cardapio", to: "cardapio#index"
end
