Rails.application.routes.draw do
  devise_for :user, :controllers => { registrations: 'registrations' }
  namespace :admin do
    resources :users
    root to: "users#index"
  end
  #devise_for :users
  resources :users
  resources :products
  resources :lineitems
  get "/mypage" => "products#myindex", as: 'mypage'
  root to: "products#home"
end
