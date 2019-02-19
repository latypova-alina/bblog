class PostDecorator < ApplicationDecorator
  decorates_association :user

  delegate :title, :content, :created_at
  delegate :full_name, to: :user, prefix: true

  def creation_date
    l(created_at, format: :us_date)
  end
end
