class LikeSerializer < ApplicationSerializer
  attributes :id, :post_id, :user_id

  has_one :post
end
