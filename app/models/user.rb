class User < ApplicationRecord
  extend Enumerize
  include PgSearch

  devise :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader

  validates :full_name, presence: true

  enumerize :role, in: %i[reader author admin], predicates: true

  has_many :posts

  scope :authors, -> { where(role: :author) }

  pg_search_scope :search, against: :full_name, using: { tsearch: { prefix: true } }
end
