Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: %i[index show] do
        resources :bookings, only: %i[index show]
      end
      resources :vehicles, only: %i[index show create] do
        resources :bookings, only: %i[index show create]
        resources :galeries, only: %i[index create]
      end
    end
  end
end
