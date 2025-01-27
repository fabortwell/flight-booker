Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions"
  }

  # Add this line to override the default Devise sign-out route
  devise_scope :user do
    get "/users/sign_out" => "devise/sessions#destroy"
  end
  root "flights#index"

  resources :flights, only: [ :index ]
  resources :bookings, only: [ :new, :create, :show ]
end
