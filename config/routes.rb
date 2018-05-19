Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'welcome/index'
  devise_for :users, :controllers => { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    resources :newspapers do
      resources :comments
    end

    resources :users

    get "nil", to: 'newspapers#nil', :as => :nil
  
    get 'tags/:tag', to: 'newspapers#index', as: :tag, :constraints  => { :tag => /[^\/]+/ }

  root to: "welcome#index"
  end
 