Rails.application.routes.draw do
  devise_for :users, controllers: { 
    omniauth_callbacks: 'users/omniauth_callbacks', registrations: "users/registrations",
    passwords: "users/passwords"}
  root to: 'goals#tumiage'
  resources :goals, shallow: true do
    resources :action_records
    resources :goal_actions
    get 'user', on: :collection
    get 'tumiage', on: :collection
  end
  resources :users
  get 'statics/help'
  get 'statics/policy'
end
