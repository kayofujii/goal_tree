Rails.application.routes.draw do
  get 'rooms/show'
  devise_for :users, controllers: { 
    omniauth_callbacks: 'users/omniauth_callbacks', registrations: "users/registrations",
    passwords: "users/passwords"}
  root to: 'goals#index'
  resources :goals, shallow: true do
    resources :action_records
    resources :goal_actions
    get 'user', on: :collection
    get 'tumiage', on: :collection
  end
  resources :users
  get 'statics/help'
  get 'statics/policy'
  get 'statics/how'
  resources :rooms
  
  mount ActionCable.server => '/cable'
end
