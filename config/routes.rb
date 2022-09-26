Rails.application.routes.draw do
  resources :doctors, only: [:show, :update]

  resources :patients, only: [:index]

  resources :hospitals, only: [:show]
end
