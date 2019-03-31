class PostsController < ApplicationController
  expose_decorated :post
  expose :like, :fetch_like
  expose_decorated :posts, :fetch_posts
  expose :sort, :sort

  private

  def fetch_posts
    Posts::FetchQuery.new(query_params).all
  end

  def sort
    @sort ||= Post.ransack(params[:q])
  end

  def fetch_like
    Like.find_by(user: current_user, post: post)
  end

  def query_params
    {
      "ransack_order_by": order_by_param,
      "page": params[:page]
    }
  end

  def order_by_param
    params[:q] ? params[:q][:s] : nil
  end
end
