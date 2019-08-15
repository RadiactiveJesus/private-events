Rails.application.routes.draw do
  resources :events
  get 'home/index'
  resources :users, only: [:new, :create, :show]
  get 'sessions/new' 
  post 'sessions/create'
  get 'sessions/destroy'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'signup', to: 'users#new', as: 'signup'
  root 'home#index'
  get 'home/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
