Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/', to: 'welcome#index', as: :home

  resources :merchants do
    resources :items, only: [:index, :new, :create]
  end

  resources :items, only: [:index, :show, :edit, :update, :destroy] do
    resources :reviews, only: [:new, :create]
  end

  resources :reviews, only: [:edit, :update, :destroy]

  get '/cart', to: 'cart#show', as: :cart
  post '/cart/:item_id', to: 'cart#add_item'
  delete '/cart', to: 'cart#empty'
  patch '/cart/:change/:item_id', to: 'cart#update_quantity'
  delete '/cart/:item_id', to: 'cart#remove_item'

  resources :orders, only: [:new, :create, :show]

  get '/register', to: 'users#register', as: :register
  post '/profile', to: 'users#create', as: :new_profile
  get '/profile/edit', to: 'users#edit', as: :edit_profile
  patch '/profile', to: 'users#update', as: :update_profile
  get '/profile', to: 'users#show', as: :profile

  get '/profile/orders', to: 'users#index'
  post '/profile/orders', to: 'orders#create'
  get '/profile/orders/:id', to: 'users#order_show', as: :order_show
  patch '/profile/orders/:id', to: 'users#order_cancel', as: :order_cancel

  get '/profile/password/edit', to: 'users#edit_password', as: :edit_password
  patch '/profile/password', to: 'users#update_password', as: :update_password

  get '/login', to: 'users#login', as: :login
  delete '/logout', to: 'users#logout', as: :logout

  post '/login', to: 'sessions#create'

  get '/admin', to: 'admin#show', as: :admin_dashboard
  get '/merchant', to: 'merchant#show', as: :merchant_dashboard

  namespace :admin do
    resources :users, only: [:show, :index]
    resources :merchants, only: [:show]
    patch '/merchants/:id/disable', to: "merchants#disable", as: :disable_merchant
    patch '/merchants/:id/enable', to: "merchants#enable", as: :enable_merchant
  end
end
