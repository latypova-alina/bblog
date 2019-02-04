module Authorization
  extend ActiveSupport::Concern
  include ActionView::ModelNaming

  included do
    rescue_from ActionPolicy::Unauthorized, with: :user_not_authorized
  end

  private

  def user_not_authorized
    redirect_to(root_path, alert: t("errors.access_denied"))
  end

  def policy_for(record:, **opts)
    super(record: convert_to_model(record), **opts)
  end
end
