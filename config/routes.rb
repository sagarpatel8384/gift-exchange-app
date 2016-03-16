Rails.application.routes.draw do
  root 'welcome#index'
  get '/signup', to: 'users#new', as: 'signup'
  get '/login', to: 'sessions#new', as: 'login'
  get '/logout', to: 'sessions#destroy', as: 'logout'
  resources :sessions, only: [:new, :create]
  resources :users, only: [:new, :create, :show, :edit, :update]
  resources :groups, only: [:new, :create, :show]
  resources :invitations, only: [:edit, :destroy]
end
