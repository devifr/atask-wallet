Rails.application.routes.draw do
  post "sign-in", to: "sessions#create"
  delete "sign-out", to: "sessions#destroy"
  resources :transactions, only: [ :create ]
  resources :wallets
  get "my-wallet", to: "wallets#my_wallet"
  get "my-transaction", to: "transactions#my_transaction"
end
