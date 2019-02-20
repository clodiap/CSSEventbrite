Rails.application.routes.draw do
  devise_for :users 
  resources :users
  resources :events do
  	resources :attendances
  end
  root 'events#index'
  namespace :admin do
  	resources :users
  	resources :events
  	resources :attendances
  	root 'admin#index'
  end
end
