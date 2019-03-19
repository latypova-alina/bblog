class Authenticate::FindOrCreateUser
  include Interactor

  delegate :auth_data, :user, to: :context
  delegate :email, :name, to: :auth_data

  def call
    context.user = find_user || create_user

    context.fail!(error: error) if user.invalid?
  end

  private

  def find_user
    by_email || by_uid_and_provider
  end

  def by_email
    User.find_by(email: email)
  end

  def by_uid_and_provider
    User.find_by(provider: provider, uid: uid)
  end

  def create_user
    User.create(create_attributes)
  end

  def create_attributes
    {
      email: email,
      full_name: name,
      password: Devise.friendly_token,
      confirmed_at: Time.current
    }
  end

  def error
    user.errors.full_messages.join(", ")
  end
end
