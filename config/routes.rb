Rails.application.routes.draw do
  root to: 'treasures#index'

  resources :treasures, only: [:new, :create, :index, :show], path: ""
end
