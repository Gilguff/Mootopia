Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "posts#index"


  # user
  resources :users do
    resource :profile, only: [ :show, :edit, :update ]

    collection do
      post :search
    end
  end

  resources :followings, only: [ :create, :destroy ]
  get "following_posts", to: "posts#following_posts", as: "following_posts"


  # post
  resources :posts do
    resources :likings, only: [ :create, :destroy ]
    resources :comments, only: %i[ create edit update destroy ]
  end
end
