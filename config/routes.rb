Rails.application.routes.draw do
  devise_for :customers
  devise_for :sitters
  devise_for :admins
  resources :admins
  resources :bookings
  resources :customers
  resources :sitters
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
