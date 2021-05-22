Rails.application.routes.draw do

  resources :tasks
  resources :users
  resources :sessions

    root to: 'sessions#new'
end
