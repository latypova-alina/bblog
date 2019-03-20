class Authenticate::AddSocialUid
  include Interactor

  delegate :auth_data, :user, to: :context
  delegate :provider, :uid, to: :auth_data

  def call
    user.update(provider: provider, uid: uid)

    context.fail!(error: error) if user.invalid?
  end

  private

  def error
    user.errors.full_messages.join(", ")
  end
end
