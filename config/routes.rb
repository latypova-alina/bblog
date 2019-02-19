Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }

  namespace :author do
    resources :posts, only: %i[index new create edit update]
  end

  resources :posts, only: %i[index show]

  root to: "posts#index"
end
