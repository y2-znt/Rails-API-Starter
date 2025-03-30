Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      scope :auth do
        post "/register", to: "auth#register"
        post "/login", to: "auth#login"
        post "/logout", to: "auth#logout"
      end
      scope :me, as: :me do
        get "", to: "me#show"
        patch "", to: "me#update"
        delete "", to: "me#destroy"
      end
      resources :users
    end
  end
end
