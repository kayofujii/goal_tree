Rails.application.routes.draw do
  devise_for :users, controllers: { 
    omniauth_callbacks: 'users/omniauth_callbacks', registrations: "users/registrations",
    passwords: "users/passwords"}
  root to: 'goals#index'
  resources :goals, shallow: true do
    resources :action_records
    resources :goal_actions
    get 'user', on: :collection
  end
  resources :users
end
