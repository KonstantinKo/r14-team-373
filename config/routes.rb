# ATTENTION: when adding new paths like /signin or /unearth_treasure, make
# sure to add the path name to friendlyID's reserved words under
# config/initializers/friendly_id.rb
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
  get '/github/content', to: 'octokit#content'

  resources :comments, only: %w(new create show), defaults: { format: 'js' }

  resources :users, only: [] do
    resources :treasures, only: [:index]
  end

  resources :treasures, only: %w(new create index show), path: "" do
    resources :votes, only: %w(create)#, defaults: { format: 'js' }
  end
end
