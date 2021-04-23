Rails.application.routes.draw do
  resources :flights, only: [:index] do
    # resources :passengers, only: [:destroy]
    resources :tickets, only: [:destroy]
  end
end
