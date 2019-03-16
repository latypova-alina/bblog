module Api
  module V1
    module UserScope
      class BaseController < Api::V1::BaseController
        before_action :authenticate_user!

        def authenticate_user!
          respond_with_unauthorized if current_user.blank?
        end
      end
    end
  end
end
