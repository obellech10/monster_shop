Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/', to: 'welcome#index', as: :home

################################
  # resources :merchants do
  #   resources :items, only: [:index, :new, :create]
  # end

  # Routes from above handrolled
  get '/merchants/:merchant_id/items', to: 'items#index', as: :merchant_items
  post '/merchants/:merchant_id/items', to: 'items#create'
  get '/merchants/:merchant_id/items/new', to: 'items#new', as: :new_merchant_item

  get '/merchants', to: 'merchants#index'
  post '/merchants', to: 'merchants#create'
  get '/merchants/new', to: 'merchants#new', as: :new_merchant
  get '/merchants/:id/edit', to: 'merchants#edit', as: :edit_merchant
  get '/merchants/:id', to: 'merchants#show', as: :merchant
  put '/merchants/:id', to: 'merchants#update'
  patch '/merchants/:id', to: 'merchants#update'
  delete '/merchants/:id', to: 'merchants#destroy'
################################
  # resources :items, only: [:index, :show, :edit, :update, :destroy] do
  #   resources :reviews, only: [:new, :create]
  # end

  # Routes from above handrolled
  post '/items/:item_id/reviews', to: 'reviews#create', as: :item_reviews
  get '/items/:item_id/reviews/new', to: 'reviews#new', as: :new_item_review

  get '/items', to: 'items#index', as: :items
  get '/items/:id/edit', to: 'items#edit', as: :edit_item
  get '/items/:id', to: 'items#show', as: :item
  patch '/items/:id', to: 'items#update'
  put '/items/:id', to: 'items#update'
  delete '/items/:id', to: 'items#destory'
################################
  # resources :reviews, only: [:edit, :update, :destroy]

  # Routes from above handrolled
  get '/reviews/:id/edit', to: 'reviews#edit', as: :edit_review
  patch '/reviews/:id', to: 'reviews#update', as: :review
  put '/reviews/:id', to: 'reviews#update'
  delete '/reviews/:id', to: 'reviews#destroy'
################################
  # Below routes are not restful routes had to keep them handrolled
  get '/cart', to: 'cart#show', as: :cart
  post '/cart/:item_id', to: 'cart#add_item'
  delete '/cart', to: 'cart#empty'
  patch '/cart/:change/:item_id', to: 'cart#update_quantity'
  delete '/cart/:item_id', to: 'cart#remove_item'
################################
  # resources :orders, only: [:new, :create, :show]

  # Routes from above handrolled
  post '/orders', to: 'orders#create'
  get '/orders/new', to: 'orders#new', as: :new_order
  get '/orders/:id', to: 'orders#show', as: :order
################################
  # Below routes are not restful routes had to keep them handrolled
  get '/register', to: 'users#register', as: :register
  post '/profile', to: 'users#create', as: :new_profile
  get '/profile/edit', to: 'users#edit', as: :edit_profile
  patch '/profile', to: 'users#update', as: :update_profile
  get '/profile', to: 'users#show', as: :profile
  get '/profile/orders', to: 'users#index'
################################
  # Below routes are not restful routes had to keep them handrolled
  post '/profile/orders', to: 'orders#create'

  get '/profile/orders/:id', to: 'users#order_show', as: :order_show
  patch '/profile/orders/:id', to: 'users#order_cancel', as: :order_cancel
  get '/profile/password/edit', to: 'users#edit_password', as: :edit_password
  patch '/profile/password', to: 'users#update_password', as: :update_password
  get '/login', to: 'users#login', as: :login
  delete '/logout', to: 'users#logout', as: :logout

  post '/login', to: 'sessions#create'
################################
  # Below routes are not restful routes had to keep them handrolled
  get '/admin/dashboard', to: 'admin#show', as: :admin_dashboard
  patch '/admin/dashboard', to: 'admin#ship_order', as: :ship_order

  get '/merchant', to: 'merchant#show', as: :merchant_dashboard
  get '/merchant/orders/:id', to: 'merchant#order_show', as: :merchant_order_show
  patch '/merchant/orders/:id', to: 'merchant#order_item_fulfillment', as: :order_item_fulfillment
################################
  # namespace :dashboard do
  #   resources :items, only: [:index, :destroy, :new, :create]
  # end

  # Routes from above handrolled
  get '/dashboard/items', to: 'dashboard/items#index'
  post '/dashboard/items', to: 'dashboard/items#create'
  get '/dashboard/items/new', to: 'dashboard/items#new', as: :new_dashboard_item
  delete '/dashboard/items/:id', to: 'dashboard/items#destroy', as: :dashboard_item
################################
  # namespace :admin do
  #   resources :users, only: [:show, :index]
  #   resources :merchants, only: [:index, :show]
  #   patch '/merchants/:id/disable', to: "merchants#disable", as: :disable_merchant
  #   patch '/merchants/:id/enable', to: "merchants#enable", as: :enable_merchant
  # end

  # Routes from above handrolled
  get '/admin/users', to: 'admin/users#index'
  get '/admin/users/:id', to: 'admin/users#show', as: :admin_user

  get '/admin/merchants', to: 'admin/merchants#index'
  get '/admin/merchants/:id', to: 'admin/merchants#show', as: :admin_merchant

  patch '/admin/merchants/:id/disable', to: 'admin/merchants#disable', as: :admin_disable_merchant
  patch '/admin/merchants/:id/enable', to: 'admin/merchants#enable', as: :admin_enable_merchant
end
