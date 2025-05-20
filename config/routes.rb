Rails.application.routes.draw do
  get "home/index"
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get "/profile", to: "users#profile", as: :profile
  get "dashboard", to: "home#dashboard", as: :dashboard

  # тимчасові маршрути для тестів
  get "vision_sharpness_tests", to: "vision_tests#sharpness", as: :vision_sharpness_tests
  get "color_blindness_tests", to: "vision_tests#color_blindness", as: :color_blindness_tests
  get "duochrome_test", to: "vision_tests#duochrome", as: :duochrome_test
  get "syvtsevs_table_test", to: "vision_tests#syvtsevs", as: :syvtsevs_table_test

  # тимчасові маршрути для вправ
  get "relaxation_exercises", to: "exercises#relaxation", as: :relaxation_exercises
  get "recovery_exercises", to: "exercises#recovery", as: :recovery_exercises

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  root to: "home#index"
  match "*unmatched", to: "application#redirect_to_root", via: :all
end
