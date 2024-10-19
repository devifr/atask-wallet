Rails.application.routes.draw do
  post "sign_in", to: "sessions#create"
  delete "sign_out", to: "sessions#destroy"
end
