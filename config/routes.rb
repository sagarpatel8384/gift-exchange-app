Rails.application.routes.draw do
  root 'welcome#index'
  get '/match', to: 'welcome#match', as: 'match'
  get '/signup', to: 'users#new', as: 'signup'
  get '/login', to: 'sessions#new', as: 'login'
  get '/logout', to: 'sessions#destroy', as: 'logout'

  resources :sessions, only: [:new, :create]
  resources :users, only: [:new, :create, :show, :edit, :update]
  resources :groups, only: [:new, :create, :show, :update, :edit]
  resources :invitations, only: [:update, :destroy, :create]
  resources :memberships, only: :update
  resources :site_admins, only: :show
end
