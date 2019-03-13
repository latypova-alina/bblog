class LikesController < ApplicationController
  expose :post, :find_post
  expose :like, -> { Like.new(post: post, user: current_user) }

  def create
    respond_with post, serializer: ::PostSerializer
  end

  private

  def find_post
    Post.find(params[:post_id])
  end
end
