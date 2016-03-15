Rails.application.routes.draw do
  root to: 'home#index'
  patch '/order', to: 'order#update'
end
