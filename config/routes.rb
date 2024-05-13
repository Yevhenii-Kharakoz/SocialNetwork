Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'home/index'
  devise_for :users
  resources :friendships
  resources :comments
  post '/set_availability', to: 'home#set_availability', as: :set_availability
  resources :posts
  resources :users do
    resources :availabilities
  end
  resources :events
  scope "(:locale)", locale: /en|uk/ do
    resources :users
  end
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
