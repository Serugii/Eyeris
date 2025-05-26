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

  get  "color_test",          to: "vision_tests#color_test"
  post "check_color_test",    to: "vision_tests#check_color_test"
  get  "result_color_test",   to: "vision_tests#result_color_test"

  post "duochrome_test/answer",    to: "vision_tests#duochrome_answer"
  get  "duochrome_test/result",    to: "vision_tests#result_duochrome_test", as: :result_duochrome_test

  get "sharpness_test", to: "vision_tests#sharpness_test", as: :sharpness_test
  get  "sharpness_test/start", to: "vision_tests#sharpness_start", as: :sharpness_test_start
  post "sharpness_test/answer", to: "vision_tests#sharpness_answer", as: :sharpness_test_answer
  get "sharpness_test/result", to: "vision_tests#sharpness_result", as: :sharpness_result


  root "home#index"
  match "*unmatched", to: "application#redirect_to_root", via: :all
end
