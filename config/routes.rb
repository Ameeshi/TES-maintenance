Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users, :only =>[:show, :index]
  
  scope "/admin" do
    resources :users, :only =>[:new, :edit, :update, :create, :destroy, :delete]
  end
  
  resources :observations
  resources :training_sessions
  resources :trainings
  resources :classrooms
  resources :schools

  resources :observations, :only => [:show, :index, :destroy, :delete] do
    # multi-step form (wicked gem)
    # nest inside foster routes so foster model can always be found even
    # if an admin fills it in (not logged in as foster-user)
    resources :observation_form
  end
  
  root to: "home#index"
  get 'home', to: redirect('/')
  
  put 'classrooms/:id/switch_active', to: 'classrooms#switch_active', as: :switch_active
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # User Routes
  match '/teachers',      to: 'users#teachers',     via: 'get'
  match '/principals',    to: 'users#principals',   via: 'get'
  match '/specialists',   to: 'users#specialists',  via: 'get'
  match '/inactive',      to: 'users#inactive',     via: 'get'
  match '/users/:id',     to: 'users#show',         via: 'get'
  match '/users',         to: 'users#index',        via: 'get'
  
  
  # Admin Stuff
  match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user
  match 'users/:id' => 'users#update', :via => :patch, :as => :admin_edit_user
  put 'users/:id/reactivate_user', to: 'users#reactivate_user', as: :reactivate_user

  # All unrecognized get requests route to 404
  get '*unmatched_route', to: redirect('/404') unless Rails.env.development?
  
end
