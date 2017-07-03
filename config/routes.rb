Rails.application.routes.draw do
  resources :orders
  resources :users
  resources :orders do
    collection do
      post 'express_checkout'
    end
  end
  resources :line_items
  resources :carts
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  #devise_for :users
  mount Ckeditor::Engine => '/ckeditor'
  resources :products
  root to: "products#catalog"
  get "checkout", to: "products#checkout"
  get "checkout/form", to: "products#checkout_form"
  post "/hook" => "orders#hook"
  post "/orders/:id" => "orders#show"
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  # devise_scope :user do
  #   delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  # end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
