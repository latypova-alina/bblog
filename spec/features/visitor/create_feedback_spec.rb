require "rails_helper"

feature "Create Feedback" do
  let(:feedback_attributes) { attributes_for :feedback }

  scenario "Visitor creates feedback" do
    visit new_feedback_path

    fill_form :feedback, feedback_attributes
    click_button "Submit"

    open_email(ENV.fetch("FEEDBACK_EMAIL"))

    expect(current_email).to have_subject("Send feedback")
    expect(current_email).to be_delivered_from(feedback_attributes[:email])

    expect(current_email).to have_body_text(feedback_attributes[:name])
    expect(current_email).to have_body_text(feedback_attributes[:email])
    expect(current_email).to have_body_text(feedback_attributes[:message])

    expect(page).to have_content("Your feedback was successfully sent!")
  end
end
