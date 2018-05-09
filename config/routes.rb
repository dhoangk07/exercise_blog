Rails.application.routes.draw do
  get 'welcome/index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    resources :newspapers do
      resources :comments
    end
    resources :users
  
  # namespace :admin do
  #   resources :users
  #   resources :newspapers
  # end

  root to: "welcome#index"
  end
 