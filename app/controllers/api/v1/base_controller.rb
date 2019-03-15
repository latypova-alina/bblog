module Api
  module V1
    class BaseController < ActionController::API

      private

      def respond_with_resource(resource, status: :ok, location: resource, include: nil, fields: nil)
        render jsonapi: resource, include: include, status: status, location: location, fields: fields
      end
    end
  end
end
