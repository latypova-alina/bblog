class UserDecorator < ApplicationDecorator
  delegate :id, :full_name, :email, :author?, :about_info

  def full_name_with_email
    "#{object.full_name} (#{object.email})"
  end
end
