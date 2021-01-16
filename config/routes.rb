Rails.application.routes.draw do
  root to: 'goals#index'
  resources :goals
end
