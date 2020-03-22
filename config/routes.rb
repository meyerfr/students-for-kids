Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :customers, controllers: {
    sessions: 'customers/sessions',
    registrations: 'customers/registrations'
  }
  devise_for :sitters, controllers: {
    sessions: 'sitters/sessions',
    registrations: 'sitters/registrations'
  }
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    registrations: 'admins/registrations'
  }
  resources :admins
  resources :bookings
  resources :customers
  resources :sitters
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
