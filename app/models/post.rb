class Post < ApplicationRecord
  include PgSearch

  belongs_to :user
  has_many :likes, dependent: :destroy

  validates :title, :content, :image, presence: true

  mount_uploader :image, PostImageUploader

  pg_search_scope :search, against: :title, using: { tsearch: { prefix: true } }

  scope :with_likes, -> do
    left_joins(:likes).group(:id)
      .select("posts.*, count(likes.id) as likes_count")
  end
end
