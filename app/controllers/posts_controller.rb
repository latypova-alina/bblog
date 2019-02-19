class PostsController < ApplicationController
  expose :posts, :fetch_posts
  expose_decorated :post

  private

  def fetch_posts
    Post.order(created_at: :desc).page(params[:page]).per(4)
  end
end
