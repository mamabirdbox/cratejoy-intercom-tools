Rails.application.routes.draw do
  root to: 'home#index'
  post '/order', to: 'order#update'
end
