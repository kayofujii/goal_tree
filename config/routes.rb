Rails.application.routes.draw do
  devise_for :users
  root to: 'goals#index'
  resources :goals, shallow: true do
    resources :action_records
    resources :goal_actions
  end
  resources :users
end
