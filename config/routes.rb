Rails.application.routes.draw do
  
  get 'simple_receipts/index'

  root to: 'sites#home'

  get "/signup", to: "store_owners#new"
  post "/signup", to: "store_owners#create"
  get "/account", to: "store_owners#show"
  post "/account/token_reset", to: "store_owners#token_reset"


  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"

  # is this a security concern? can this be overidden in chrome?
  get "/logout", to: "sessions#destroy", as: "logout"

  get "/receipts", to: "simple_receipts#index"
  post "/receipts", to: "simple_receipts#create"
  get "/receipts/new", to: "simple_receipts#new", as: "new_receipt"

  
end
