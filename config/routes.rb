Rails.application.routes.draw do
  post "sign-in", to: "sessions#create"
  delete "sign-out", to: "sessions#destroy"
  resources :transactions, only: [:create]
end
