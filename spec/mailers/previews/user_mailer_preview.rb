class UserMailerPreview < ActionMailer::Preview
  def feedback
    feedback = FactoryBot.build(:feedback)

    UserMailer.feedback(feedback)
  end
end
