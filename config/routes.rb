Rails.application.routes.draw do
  resources :line_items
  resources :carts
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  mount Ckeditor::Engine => '/ckeditor'
  resources :products
  root to: "products#catalog"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
