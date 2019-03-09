class UserDecorator < ApplicationDecorator
  delegate :id, :full_name, :email, :author?, :about_info, :avatar_url

  def large_image_url
    avatar_url(:large)
  end

  def medium_image_url
    avatar_url(:medium)
  end

  def full_name_with_email
    "#{object.full_name} (#{object.email})"
  end

  def like_class(post_id)
    liked?(post_id) ? "fi-heart picked" : "fi-heart"
  end

  private

  def liked?(post_id)
    object.likes.find_by(post_id: post_id)
  end
end
