class UserDecorator < ApplicationDecorator
  delegate :id, :full_name, :email, :author?, :about_info, :avatar_url

  def large_image_url
    avatar_url(:large)
  end

  def full_name_with_email
    "#{object.full_name} (#{object.email})"
  end
end
