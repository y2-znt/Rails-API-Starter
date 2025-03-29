Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :create, :show, :update, :destroy]
      post "auth/register", to: "auth#register"
      post "auth/login", to: "auth#login"
      get "auth/profile", to: "auth#profile"
    end
  end
end
