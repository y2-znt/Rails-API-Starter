Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      scope :auth do
        post "/register", to: "auth#register"
        post "/login", to: "auth#login"
      end
      scope :me do
        get "", to: "me#show"
        patch "", to: "me#update"
        delete "", to: "me#destroy"
      end
      resources :users
    end
  end
end
