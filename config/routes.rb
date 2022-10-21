Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post 'api/v1/auth/login', to: 'authentication#login'
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: %i[index show create update destroy] do
        resources :bookings, only: %i[index show create]
      end
      resources :vehicles, only: %i[index show create] do
        resources :bookings, only: %i[index show create]
        resources :galeries, only: %i[index create]
      end
    end
  end
end
