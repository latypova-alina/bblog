require "rails_helper"

feature "Create Post" do
  include_context "author signed in"

  scenario "Author creates post" do
    visit new_author_post_path

    fill_in "Title", with: "Cool Post"
    fill_in "Content", with: "Post Content"

    click_on "Create Post"

    expect(page).to have_content("Post was successfully created.")
    expect(page).to have_content("Cool Post")
  end

  scenario "Author creates post with invalid data" do
    visit new_author_post_path

    fill_in "Title", with: "Cool Post"
    click_on "Create Post"

    expect(page).to have_content("Post could not be created.")
    expect(page).to have_content("Content can't be blank")
  end
end
