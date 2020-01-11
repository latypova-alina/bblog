class PostsController < ApplicationController
  expose_decorated :post
  expose :like, :fetch_like
  expose_decorated :posts, :fetch_posts
  expose :sort, :sort

  private

  def fetch_posts
    Posts::FetchQuery.new(sort.result, params).all
  end

  def sort
    @sort ||= Post.ransack(params[:q])
  end

  def fetch_like
    Like.find_by(user: current_user, post: post)
  end
end
