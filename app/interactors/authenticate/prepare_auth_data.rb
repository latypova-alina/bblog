class Authenticate::PrepareAuthData
  include Interactor

  delegate :auth_data, to: :context

  def call
    context.auth_data = AuthDataDecorator.new(auth_data)
  end
end
