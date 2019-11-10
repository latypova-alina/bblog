class LikeSerializer < ApplicationSerializer
  attributes :id, :user_id

  has_one :post
end
