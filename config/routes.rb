
Rails.application.routes.draw do
  get "/supplier/new", to: "supplier#new"
  post "/supplier", to: "supplier#create"
  get "welcome/index"
  resources :supplier
end
