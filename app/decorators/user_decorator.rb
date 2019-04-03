class UserDecorator < ApplicationDecorator
  delegate :id, :full_name, :email, :author?, :about_info, :avatar_url

  def large_image_url
    avatar_url(:large)
  end

  def medium_image_url
    avatar_url(:medium)
  end

  def thumbnail_image_url
    avatar_url(:thumbnail)
  end

  def full_name_with_email
    "#{object.full_name} (#{object.email})"
  end
end
