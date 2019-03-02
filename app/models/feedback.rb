class Feedback
  include ActiveModel::Model

  attr_accessor :email, :name, :message

  validates :email, :name, :message, presence: true
  validates :email, format: Devise.email_regexp

  def save
    valid?
  end

  def attributes=(attributes)
    attributes.each do |key, value|
      public_send "#{key}=", value
    end
  end
end
