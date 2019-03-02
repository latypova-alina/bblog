require "rails_helper"

feature "Update Post" do
  include_context "author signed in"

  before do
    create :post, user: current_user, title: "Cool Post"
  end

  scenario "Author updates post" do
    visit author_posts_path

    click_on "Edit"

    fill_in "Title", with: "Super Cool Post"
    click_on "Update Post"

    expect(page).to have_content("Post was successfully updated.")
    expect(page).to have_content("Super Cool Post")
  end
end
