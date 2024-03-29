class User
  class ParameterSanitizer < Devise::ParameterSanitizer
    USER_PARAMS = %i(
      full_name
      email
      avatar
      password
      password_confirmation
      about_info
    ).freeze

    def initialize(*)
      super
      permit(:sign_up, keys: USER_PARAMS)
      permit(:account_update, keys: USER_PARAMS)
    end
  end
end
