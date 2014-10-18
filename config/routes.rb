Rails.application.routes.draw do
  root to: 'treasures#index'

  get '/tags/autocomplete', to: 'tags#autocomplete', defaults: { format: 'json' }

  resources :treasures, only: [:new, :create, :index, :show], path: ""
end
