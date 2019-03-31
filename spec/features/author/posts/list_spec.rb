require "rails_helper"

feature "List Posts" do
  include_context "author signed in"

  let(:my_post) { create :post, user: current_user, title: "My Post" }

  before do
    create :post, title: "Other Users Post"
    create_list :like, 5, post: my_post
  end

  scenario "Author sees his/her posts" do
    visit author_posts_path

    expect(page).to have_content("My Post")
    expect(page).not_to have_content("Other Users Post")
    expect(page).to have_content(5)
  end
end
