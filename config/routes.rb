Rails.application.routes.draw do
  resources :observations
  resources :training_sessions
  resources :trainings
  resources :classrooms
  resources :schools
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
