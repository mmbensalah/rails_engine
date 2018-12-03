Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find'                   => 'find#show'
        get '/find_all'               => 'find#index'
        get '/:id/items'              => 'items#index'
        get '/:id/invoices'           => 'invoices#index'
        get '/most_revenue'           => 'most_revenue#index'
        get '/most_items'             => 'most_items#index'
        get '/revenue'                => 'revenue#index'
      end
      namespace :customers do
        get '/find'                   => 'find#show'
        get '/find_all'               => 'find#index'
      end
      namespace :items do
        get '/find'                   => 'find#show'
        get '/find_all'               => 'find#index'
        get '/:id/invoice_items'      => 'invoice_items#index'
        get '/:id/merchant'           => 'merchant#show'
      end
      namespace :invoices do
        get '/find'                   => 'find#show'
        get '/find_all'               => 'find#index'
        get '/:id/transactions'       => 'transactions#index'
        get '/:id/invoice_items'      => 'invoice_items#index'
        get '/:id/items'              => 'items#index'
        get '/:id/customer'           => 'customers#show'
        get '/:id/merchant'           => 'merchants#show'
      end
      namespace :invoice_items do
        get '/find'                   => 'find#show'
        get '/find_all'               => 'find#index'
        get '/:id/item'               => 'items#show'
        get '/:id/invoice'            => 'invoices#show'
      end
      namespace :transactions do
        get '/find'                   => 'find#show'
        get '/find_all'               => 'find#index'
        get '/:id/invoice'            => 'invoice#show'
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
