require "rails_helper"

feature "Delete Post" do
  include_context "admin signed in"

  before { create :post, title: "Cool Post" }

  scenario "Admin deletes post" do
    visit admin_posts_path

    click_on "Delete"

    expect(page).to have_content("Post was successfully destroyed.")
    expect(page).not_to have_content("Cool Post")
  end
end
