class FeedbacksController < ApplicationController
  expose :feedback

  def create
    FeedbackMailer.send_feedback(feedback).deliver_now! if feedback.valid?

    respond_with feedback, location: root_path
  end

  private

  def feedback_params
    params.require(:feedback).permit(:email, :name, :message)
  end
end
