Rails.application.routes.draw do
  devise_for :users
  get "home/index"

  get "up" => "rails/health#show", as: :rails_health_check
  get "/profile", to: "users#profile", as: :profile
  get "dashboard", to: "home#dashboard", as: :dashboard

  get "vision_sharpness_tests", to: "vision_tests#sharpness", as: :vision_sharpness_tests
  get "color_blindness_tests", to: "vision_tests#color_blindness", as: :color_blindness_tests
  get "duochrome_test", to: "vision_tests#duochrome", as: :duochrome_test
  get "syvtsevs_table_test", to: "vision_tests#syvtsevs", as: :syvtsevs_table_test

  get "relaxation_exercises", to: "exercises#relaxation", as: :relaxation_exercises
  get "recovery_exercises", to: "exercises#recovery", as: :recovery_exercises

  root "home#index"
  match "*unmatched", to: "application#redirect_to_root", via: :all
end
