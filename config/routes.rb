Rails.application.routes.draw do
  resources :flights, only: [:index] do
    resources :tickets, only: [:destroy]
  end

  resources :airlines, only: [:show]
end
