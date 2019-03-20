class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    authenticate
  end

  private

  def authenticate
    if authenticate_user.success?
      sign_in_and_redirect authenticate_user.user
    else
      redirect_to root_path, alert: authenticate_user.error
    end
  end

  def authenticate_user
    @authenticate_user ||= Authenticate.call(auth_data: auth_data)
  end

  def auth_data
    request.env["omniauth.auth"]
  end
end
