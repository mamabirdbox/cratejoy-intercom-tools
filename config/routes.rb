Rails.application.routes.draw do
  root to: 'home#index'
  patch '/order', to: 'order#update'
  post '/order', to: 'order#update'
  patch '/customer/:id/intercom', to: 'customer#retry_intercom', as: 'customer_retry'
  post '/webhooks/cratejoy/new', to: 'crate_joy#new'
end
