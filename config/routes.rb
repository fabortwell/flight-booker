Rails.application.routes.draw do
  devise_for :users
  root "flights#index"

  resources :flights, only: [ :index ]
  resources :bookings, only: [ :new, :create, :show ]
end
