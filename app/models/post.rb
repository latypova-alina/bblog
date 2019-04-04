class Post < ApplicationRecord
  include PgSearch

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :title, :content, :image, presence: true

  mount_uploader :image, PostImageUploader

  pg_search_scope :search, against: :title, using: { tsearch: { prefix: true } }

  scope :with_likes, -> { left_joins(:likes).group(:id).select("posts.*, count(likes.id) as likes_count") }

  scope :ransack_order, ->(param) { order(sanitize_sql(param)) }
end
