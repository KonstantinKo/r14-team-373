Rails.application.routes.draw do
  root to: 'visitors#index'

  resources :treasures, only: [:show, :new, :create]

  get '/tags/autocomplete', to: 'tags#autocomplete', defaults: { format: 'json' }
end
