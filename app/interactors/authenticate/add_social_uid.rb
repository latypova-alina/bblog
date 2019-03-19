class Authenticate::AddSocialUid
  include Interactor

  delegate :auth_data, :user, to: :context

  def call
    user.update(provider: auth_data["provider"], uid: auth_data["uid"])

    context.fail!(error: error) if user.invalid?
  end

  private

  def error
    user.errors.full_messages.join(", ")
  end
end
