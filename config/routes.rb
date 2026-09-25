Rails.application.routes.draw do
  get "tags_theaters/destroy"
  get "tags_companions/destroy"
  get "tags/show"
  get "mypage/show"
  devise_for :users
  resources :records, only: %i[new create index show edit update destroy] do
    collection do
      get :search
    end
    resources :memory_photos, only: %i[destroy], controller: "record_memory_photos"
  end
  resources :movie_searches, only: %i[index]
  resource :mypage, only: %i[show], controller: "mypage"
  resource :tags, only: %i[show], controller: "tags" do
    resources :theaters, only: %i[destroy], controller: "tag_theaters"
    resources :companions, only: %i[destroy], controller: "tag_companions"
  end

  root "top#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
