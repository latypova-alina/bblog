class PostsController < ApplicationController
  expose_decorated :post
  expose :like, :fetch_like
  expose_decorated :posts, :fetch_posts
  expose :sort, :sort

  private

  def fetch_posts
    sort_result = count_sort? ? sort.result.order(params[:q][:s]) : sort.result

    sort_result.page(params[:page]).per(4)
  end

  def fetch_like
    Like.find_by(user: current_user, post: post)
  end

  def count_sort?
    params[:q] && params[:q][:s].include?("count")
  end

  def sort
    @sort ||= Post.with_likes.ransack(params[:q])
  end
end
