Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find'                   => 'find#show'
        get '/find_all'               => 'find#index'
        get '/most_revenue'           => 'most_revenue#index'
        get '/most_items'             => 'most_items#index'
        get '/revenue'                => 'revenue#index'
      end
      namespace :customers do
        get '/find'                   => 'find#index'
      end
      namespace :items do
        get '/find'                   => 'find#index'
      end
      namespace :invoices do
        get '/find'                   => 'find#index'
      end
      namespace :invoice_items do
        get '/find'                   => 'find#index'
      end
      namespace :transactions do
        get '/find'                   => 'find#index'
      end
      resources :merchants,    only: [:index, :show]
      resources :customers,    only: [:index, :show]
      resources :items,        only: [:index, :show]
      resources :invoices,     only: [:index, :show]
      resources :invoice_items,only: [:index, :show]
      resources :transactions, only: [:index, :show]
    end
  end
end
