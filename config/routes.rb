Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :customers
  devise_for :sitters
  devise_for :admins
  resources :admins
  resources :bookings
  resources :customers
  resources :sitters
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
