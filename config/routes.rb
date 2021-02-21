Rails.application.routes.draw do
  devise_for :users
  root to: 'goals#user'
  resources :goals, shallow: true do
    resources :action_records
    resources :goal_actions
    get 'user', on: :collection
  end
  resources :users
end
