Rails.application.routes.draw do
  root to: 'treasures#index'

  get '/tags/autocomplete', to: 'tags#autocomplete', defaults: { format: 'json' }
  match '/auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'

  get '/unearth_treasure' => 'treasures#unearth_treasure', as: :unearth_treasure

  get '/github/tree', to: 'octokit#tree'
  get '/github/repos', to: 'octokit#repos'
  get '/github/branches', to: 'octokit#branches'

  resources :treasures, only: [:new, :create, :index, :show], path: ""
end
