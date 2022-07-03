Rails.application.routes.draw do
  root to: 'static_pages#homepage'
  devise_for :users
  resources :users, only: [:show, :edit, :update]
  resources :products
  resources :carts
  resources :cart_products
  resources :orders
  resources :restaurants

  scope "/checkout" do
    post "create", to: "checkout#create", as: "checkout_create"
    get "cancel", to: "checkout#cancel", as: "checkout_cancel"
    get "success", to: "checkout#success", as: "checkout_success"
  end

  # Added by administrate gem
  namespace :admin do
    resources :users
    resources :orders
    resources :order_products
    resources :carts
    # resources :cart_products
    resources :categories
    resources :products
    resources :ingredients
    resources :units
    resources :product_ingredients
    resources :restaurants
    resources :comments

    root to: "carts#index"
  end
end
