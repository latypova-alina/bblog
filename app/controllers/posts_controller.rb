class PostsController < ApplicationController
  expose_decorated :post
  expose :like, :fetch_like
  expose_decorated :posts, :fetch_posts

  private

  def fetch_posts
    Post.order(created_at: :desc).page(params[:page]).per(4)
  end

  def fetch_like
    Like.find_by(user: current_user, post: post)
  end
end
