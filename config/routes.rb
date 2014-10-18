Rails.application.routes.draw do
  root to: 'visitors#index'

  resources :treasures, only: [:index, :show, :new, :create]

  get '/tags/autocomplete', to: 'tags#autocomplete', defaults: { format: 'json' }
end
