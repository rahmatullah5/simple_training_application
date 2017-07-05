Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  require 'sidekiq/web'
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  devise_for :admin_users, ActiveAdmin::Devise.config
  mount Ckeditor::Engine => '/ckeditor'
  mount Sidekiq::Web => '/sidekiq'

  resources :line_items , :carts

  resources :users do
    get "profile" , to: "users#show" , on: :member
  end
  
  resources :products do
    member do
      get 'checkout'
    end
    collection do
      get 'checkout_form'
    end
  end

  resources :orders do
    post "/orders/:id" => "orders#show" , on: :member
    collection do
      post 'express_checkout'
      post "/hook" => "orders#hook"
    end
  end

  get "search", to: "search#search"
  root to: "products#catalog"
end
