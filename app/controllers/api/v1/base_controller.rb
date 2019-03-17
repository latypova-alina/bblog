module Api
  module V1
    class BaseController < ActionController::API
      private

      def respond_with_resource(resource, status: :ok, location: resource, include: nil, fields: nil)
        render jsonapi: resource, include: include, status: status, location: location, fields: fields
      end

      def respond_with_error(code, error_message = nil)
        Error.new(code: code, error_message: error_message).tap do |error|
          render json: error.to_json, status: error.status
        end
      end

      def respond_with_unauthorized
        respond_with_error(:unauthorized, I18n.t("errors.unauthorized"))
      end
    end
  end
end
