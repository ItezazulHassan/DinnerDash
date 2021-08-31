# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controller: { registrations: "devise/registrations" }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "welcome#index"
  resources :categories
  resources :line_items
  resources :items
  resources :carts
  resources :administrator
  resources :cart_items
  resources :find
  resources :users do
    resources :orders
  end
  # get "login" => "sessions#new"
  get "/payment/processed" => "checkouts#create", as: :get_payment_completed
  get "admin" => "administrator#show", as: :dashboard
  get "admin/items" => "administrator#item_index", as: :admin_items
  get "admin/orders" => "administrator#order_index", as: :admin_orders
  get "admin/users" => "administrator#user_index", as: :admin_users
  get "admin/categories" => "administrator#category_index",
      as: :admin_categories
  # post "login" => "sessions#create"
  get "admin/ordersbystatus" => "administrator#filter_status", as: :admin_orders_filter
  post "checkout" => "checkouts#show", as: :checkout
  post "carts/checkout" => "carts#checkout", as: :cart_checkout
  post "payment" => "checkouts#create", as: :payment
  post "/payment/processed" => "checkouts#create", as: :payment_completed
  patch "order_status" => "administrator#update", as: :order_status
  patch "/items/:item_id/edit_status" => "items#edit_status", as: :edit_status
  # delete "logout" => "sessions#destroy"
  delete "carts/:item_id/", to: "carts#destroy", as: :cart_item_delete
end
