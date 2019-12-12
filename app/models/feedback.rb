class Feedback
  include ActiveModel::Model

  attr_accessor :email, :name, :message

  validates :email, :name, :message, presence: true
  validates :email, format: Devise.email_regexp
end
