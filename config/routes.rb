Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  patch '/order', to: 'order#update'
  post '/order', to: 'order#update'
  patch '/customer/:id/intercom', to: 'customer#retry_intercom', as: 'customer_retry'
  get '/customer', to: 'customer#index'
  post '/customer/search', to: 'customer#search'
  post '/webhooks/cratejoy/new', to: 'crate_joy#new'
  get '/order/update/:date', to: 'order#manual_update', as: 'order_manual_update'
end
