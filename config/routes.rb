Rails.application.routes.draw do
  devise_for :users
  resources :vehicles, only: [:index, :new, :create, :edit, :update]
  resources :prices_by_distances, only: [:index,:new, :create, :edit, :update]
  resources :prices_by_weights, only: [:index,:new, :create, :edit, :update]
  resources :prices, only: [:index]
  resources :modalities, only: [:index, :new, :create, :show, :update] do
    post 'inactivate', on: :member
  end
  resources :delivery_times, only: [:index, :new, :create, :edit, :update]

  resources :orders, only: [:index,:new, :create, :show, :update] do
    post 'close', on: :member
    get 'search', on: :collection
  end

  root to: "home#index"
end

