Rails.application.routes.draw do
  devise_for :users
  resources :vehicles, only: [:index,:new, :create]
  root to: "home#index"
end

