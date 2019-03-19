class AuthDataDecorator < ApplicationDecorator
  delegate :provider, :uid, :info
  delegate :email, :name, to: :info, allow_nil: true
end
