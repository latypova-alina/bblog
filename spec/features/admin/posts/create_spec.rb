require "rails_helper"

feature "Create Post" do
  include_context "admin signed in"

  before do
    create :user, full_name: "Rose Potter"
    create :user, :author, full_name: "John Smith"
  end

  let(:author_selector_options) do
    page.all("select#post_user_id option").map(&:text)
  end

  scenario "Admin creates post" do
    visit new_admin_post_path

    expect(author_selector_options).to have_content("John Smith")
    expect(author_selector_options).not_to have_content("Rose Potter")

    fill_in "Title", with: "Cool Post"
    attach_file("post[image]")
    fill_in "Content", with: "Cool Post Content"

    click_on "Create Post"

    expect(page).to have_content("Post was successfully created.")
    expect(page).to have_content("Cool Post")
  end

  scenario "Admin creates post with invalid data" do
    visit new_admin_post_path

    click_on "Create Post"

    expect(page).to have_content("Post could not be created.")
    expect(page).to have_content("Title*\ncan't be blank")
    expect(page).to have_content("Content*\ncan't be blank")
  end
end
