class LikesController < ApplicationController
  expose :post, :find_post

  def create
    post.likes.create(user_id: current_user.id)
  end

  private

  def find_post
    Post.find(params[:post_id])
  end

  def like_params
    params.require(:like).permit(:post_id).merge(user: current_user)
  end
end
