Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'welcome/index'
  devise_for :users, :controllers => { :registrations => 'registrations', :omniauth_callbacks => "users/omniauth_callbacks" }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    resources :newspapers do
      resources :comments
      get :search, on: :collection
      get :hide, on: :member
      get :hidden, on: :collection
      get :display, on: :member
    end

    resources :users do
      get :search, on: :collection
    end

    resources :newspapers do 
      member do
        put "like" => "newspapers#vote"
        put "unlike" => "newspapers#unlike"
      end  
    end

    get "nil", to: 'newspapers#nil', :as => :nil
  
    get 'tags/:tag', to: 'newspapers#index', as: :tag, :constraints  => { :tag => /[^\/]+/ }
  root to: "welcome#index"
end
