Rails.application.routes.draw do
  resources :treasures, only: [:new, :create, :index, :show], path: ""
end
