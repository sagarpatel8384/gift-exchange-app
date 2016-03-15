Rails.application.routes.draw do
  root 'welcome#index'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  resources :users
end
