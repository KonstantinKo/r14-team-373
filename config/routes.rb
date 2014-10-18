Rails.application.routes.draw do
  root to: 'visitors#index'

  resources :treasures, only: [:show, :new, :create]
end
