Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "home#index"

  resources :reviews do
    resource :like, only: [ :create, :destroy ]
    resources :comments, only: [ :create, :destroy ]
  end

  resources :notifications, only: [ :index ] do
    collection do
      patch :read_all
    end
  end

  get "maps", to: "maps#index"
  get "terms", to: "static_pages#terms"
  get "privacy", to: "static_pages#privacy"

  resources :users, only: [ :show, :index ] do
    resource :follow, only: [ :create, :destroy ]
  end

  namespace :admin do
    get "login", to: "sessions#new"
    post "login", to: "sessions#create"
    delete "logout", to: "sessions#destroy"
    root to: "dashboard#index"
    resources :users, only: [ :index, :destroy ]
    resources :reviews, only: [ :index, :destroy ]
  end
end
