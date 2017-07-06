Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users, :only =>[:show]
  
  resources :observations
  resources :training_sessions
  resources :trainings
  resources :classrooms
  resources :schools

  root to: "home#index"
  get 'home', to: redirect('/')
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # User Routes
  match '/teachers',   to: 'users#teachers',   via: 'get'
  match '/users/:id',  to: 'users#show',       via: 'get'
  match '/users',      to: 'users#index',      via: 'get'

end
