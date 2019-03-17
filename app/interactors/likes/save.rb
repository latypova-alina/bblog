module Likes
  class Save
    include Interactor

    delegate :like, to: :context

    def call
      like.save

      context.fail!(error_code: :invalid_record, error_message: error_message) if like.invalid?
    end

    private

    def error_message
      like.errors.full_messages.join(", ")
    end
  end
end
