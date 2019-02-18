Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }

  namespace :author do
    resources :posts, only: %i[index new create edit update show]
  end

  root to: "pages#home"
end
