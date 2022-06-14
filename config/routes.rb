Rails.application.routes.draw do
  root to: 'static_pages#homepage'
  devise_for :users
  
  resources :products
  resources :carts
  resources :cart_products
  scope "/checkout" do
    post "create", to: "checkout#create", as: "checkout_create"
    get "cancel", to: "checkout#cancel", as: "checkout_cancel"
    get "success", to: "checkout#success", as: "checkout_success"
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
