class Error
  include ActiveModel::Model
  include ActiveModel::Serialization

  CODES_TO_STATUS = {
    unauthorized: :unauthorized,
    record_not_found: :not_found,
  }.freeze

  attr_accessor :code, :error_message

  def detail
    error_message || I18n.t("errors.#{code}")
  end

  def status
    CODES_TO_STATUS[code]
  end

  def to_json
    ActiveModelSerializers::SerializableResource.new([self], adapter: :json).to_json
  end
end
