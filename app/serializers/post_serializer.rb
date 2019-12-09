class PostSerializer < ApplicationSerializer
  attributes :title, :content, :likes_count

  def likes_count
    object.likes.count
  end
end
