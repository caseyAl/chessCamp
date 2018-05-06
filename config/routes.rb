Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # Semi-static page routes
  get 'home', to: 'home#index', as: :home
  get 'home/about', to: 'home#about', as: :about
  get 'home/contact', to: 'home#contact', as: :contact
  get 'home/privacy', to: 'home#privacy', as: :privacy
  get 'home/search', to: 'home#search', as: :search
  root 'home#index'

  # Routes for main resources
  resources :users
  resources :sessions
  resources :camps
  resources :instructors
  resources :locations
  resources :curriculums
  resources :students
  resources :families



  # Routes for managing camp instructors
  get 'user/edit' => 'users#edit', :as => :edit_current_user
  get 'signup' => 'users#new', :as => :signup
  get 'login' => 'sessions#new', :as => :login
  get 'logout' => 'sessions#destroy', :as => :logout
  #get 'camp_instructors/new', to: 'camp_instructors#new', as: :new_camp_instructor
  #post 'camp_instructors', to: 'camp_instructors#create', as: :camp_instructors
  #delete 'camp_instructors', to: 'camp_instructors#destroy', as: :camp_instructor


    # Routes for managing camp instructors
    get 'camps/:id/instructors', to: 'camps#instructors', as: :camp_instructors
    post 'camps/:id/instructors', to: 'camp_instructors#create', as: :create_instructor
    delete 'camps/:id/instructors/:instructor_id', to: 'camp_instructors#destroy', as: :remove_instructor
end

