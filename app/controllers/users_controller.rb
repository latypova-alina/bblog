class UsersController < ApplicationController
  expose_decorated :user, scope: -> { User.authors }

  expose_decorated :posts, :fetch_posts

  def show
  end

  private

  def fetch_posts
    Post.where(user: user).order(created_at: :desc)
  end
end
