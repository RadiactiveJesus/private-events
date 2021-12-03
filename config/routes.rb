Rails.application.routes.draw do
  resources :events
  get 'attend', to: 'events#attend', as: 'attend'
  get 'home/index'
  resources :users, only: [:new, :create, :show]
  get 'sessions/new' 
  post 'sessions/create'
  get 'sessions/destroy'
  get '/events', to: 'events#index'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'signup', to: 'users#new', as: 'signup'
  root 'home#index'
  get 'home/index'
  get '/invitations', to: 'users#check_invites'
  patch '/invitations', to: 'users#respond_to_invites'
  get '/invite', to: 'events#edit'
  patch '/invite', to: 'events#update'
  resources :events_attendee, only: %i[edit update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
