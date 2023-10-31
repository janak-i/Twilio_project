Rails.application.routes.draw do
  post "/login", to: "sessions#login"
  post "/signup", to: "sessions#sign_up"
  get "/display_users", to: "sessions#display_users"
  post 'sessions/forgot', to: 'sessions#forgot'
  post 'sessions/reset', to: 'sessions#reset'
  resources :todos
end