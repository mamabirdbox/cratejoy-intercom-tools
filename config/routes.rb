Rails.application.routes.draw do
  root to: 'home#index'
  patch '/order', to: 'order#update'
  patch '/customer/:id/intercom', to: 'customer#retry_intercom', as: 'customer_retry'
end
