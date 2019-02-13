Rails.application.routes.draw do
  get 'products/edit'

  devise_for :user, :controllers => { registrations: 'registrations' }
  namespace :admin do
    resources :users
    root to: "users#index"
  end
  #devise_for :users
  resources :users
  resources :products
  root to: "products#home"
end
