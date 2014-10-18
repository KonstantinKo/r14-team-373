Rails.application.routes.draw do
  root to: 'visitors#index'

  resources :treasures, only: [:new, :create, :index, :show]
end
