require "rails_helper"

feature "About Us Page" do
  scenario "Visitor sees About Us page" do
    visit about_path

    expect(page).to have_content("About Us")
  end
end
