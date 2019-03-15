Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :users, controllers: { registrations: "users/registrations" }

  get "/about", to: "pages#about"

  namespace :author do
    resources :posts, only: %i[index new create edit update destroy]
  end

  namespace :api, defaults: { format: "jsonapi" } do
    namespace :v1 do
      resources :likes, only: :create
    end
  end

  resources :search, only: :index

  resources :users, only: :show

  resource :feedback, only: %i[new create]

  root to: "posts#index"
end
