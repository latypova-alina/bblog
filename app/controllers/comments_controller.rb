class CommentsController < ApplicationController
  expose_decorated :post
  expose_decorated :comments, :fetch_comments

  def index
  end

  private

  def fetch_comments
    Comment.where(post: post)
           .order(created_at: :desc)
           .page(params[:page]).per(10)
  end
end
