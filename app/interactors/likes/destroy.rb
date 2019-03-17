module Likes
  class Destroy
    include Interactor

    delegate :like, to: :context

    def call
      like.destroy || context.fail!(error_code: :invalid_record, error_message: error_message)
    end

    private

    def error_message
      order_item.errors.full_messages.join(", ")
    end
  end
end
