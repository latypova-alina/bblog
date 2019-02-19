require "rails_helper"

feature "Delete Post" do
  include_context "author signed in"

  before do
    create :post, user: current_user, title: "Cool Post"
  end

  scenario "Author deletes post" do
    visit author_posts_path

    expect(page).to have_content("Cool Post")

    click_on "Delete"

    expect(page).to have_content("Post was successfully destroyed.")
    expect(page).not_to have_content("Cool Post")
  end
end
