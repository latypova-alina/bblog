require "rails_helper"

feature "List Posts" do
  include_context "author signed in"

  before do
    create :post, title: "Other Users Post"
    create :post, user: current_user, title: "My Post"
  end

  scenario "Author sees his/her posts" do
    visit author_posts_path

    expect(page).to have_content("My Post")
    expect(page).not_to have_content("Other Users Post")
  end
end
