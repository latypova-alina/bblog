class LikeSerializer < ApplicationSerializer
  attributes :id, :post_id, :user_id, :likes_count

  def likes_count
    object.post.likes.count
  end
end
