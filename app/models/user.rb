class User < ApplicationRecord
  extend Enumerize

  devise :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :trackable, :validatable

  validates :full_name, presence: true

  enumerize :role, in: %i[reader author admin], predicates: true

  has_many :posts

  scope :authors, -> { where(role: :author) }
end
