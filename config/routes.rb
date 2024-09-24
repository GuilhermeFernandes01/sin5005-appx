
Rails.application.routes.draw do
  get "/employees", to: "employees#index"
  get "employees/index"
  get "employees/new"
  resources :employees, only: [ :new, :create ]
  
  get "/supplier/new", to: "supplier#new"
  post "/supplier", to: "supplier#create"
  resources :supplier


  get "/clientes", to: "clientes#index"
  get "clientes/index"
  get "clientes/new"
  get "clientes/show"
  resources :clientes


  get "/products/new", to: "products#new", as: "new_article"
  post "/products", to: "products#create"
  # resources :products, only: [ :new, :create ]


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
