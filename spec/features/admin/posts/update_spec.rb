require "rails_helper"

feature "Update Post" do
  include_context "admin signed in"

  let(:post) { create :post, title: "Cool Post" }

  scenario "Admin updates post" do
    visit edit_admin_post_path(post)

    fill_in "Title", with: "Fantastic Post"

    click_on "Update Post"

    expect(page).not_to have_content("Cool Post")
    expect(page).to have_content("Fantastic Post")
    expect(page).to have_content("Post was successfully updated.")
  end

  scenario "Admin updates post with invalid data" do
    visit edit_admin_post_path(post)

    fill_in "Title", with: ""

    click_on "Update Post"

    expect(page).to have_content("Title*\ncan't be blank")
    expect(page).to have_content("Post could not be updated.")
  end
end
