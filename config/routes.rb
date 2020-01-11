Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  get "/about", to: "pages#about"

  namespace :author do
    resources :posts, only: %i(index new create edit update destroy)
  end

  namespace :api, defaults: { format: "jsonapi" } do
    namespace :v1 do
      scope module: :user_scope do
        resources :posts, only: [] do
          resources :likes, only: %i(create destroy), module: :posts
        end
      end
    end
  end

  resources :posts, only: %i(show index)

  resources :search, only: :index

  resources :users, only: :show

  resource :feedback, only: %i(new create)

  root to: "posts#index"
end
