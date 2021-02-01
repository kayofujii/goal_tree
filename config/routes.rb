Rails.application.routes.draw do
  devise_for :users
  root to: 'goals#index'
  resources :goals
  resources :users
  resources :actions
  resources :action_records
end
