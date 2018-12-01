Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/most_revenue'           => 'most_revenue#index'
        get '/most_items'             => 'most_items#index'
        get '/revenue'                => 'revenue#index'
      end
      resources :merchants,    only: [:index, :show]
      resources :customers,    only: [:index, :show]
    end
  end
end
