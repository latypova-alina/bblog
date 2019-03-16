class PostDecorator < ApplicationDecorator
  decorates_association :user

  delegate :title, :content, :created_at, :image_url, :id
  delegate :full_name, to: :user, prefix: true

  def creation_date
    l(created_at, format: :us_date)
  end

  def medium_image_url
    image_url(:medium)
  end

  def large_image_url
    image_url(:large)
  end

  def like_class(user_id)
    liked_by?(user_id) ? "like fi-heart picked" : "like fi-heart"
  end

  private

  def liked_by?(user_id)
    return false if user_id.blank?

    object.likes.find_by(user_id: user_id)
  end
end
