class CommentDecorator < ApplicationDecorator
  decorates_association :user

  delegate :content
  delegate :full_name, :thumbnail_image_url, to: :user, prefix: true
end
