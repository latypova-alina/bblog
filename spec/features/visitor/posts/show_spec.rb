require "rails_helper"

feature "Show Post" do
  let(:post) { create :post, :with_likes, title: "Winter is coming.", content: "Hodor! Hodor." }
  let(:likes_counter) { ".likes-info .likes-count" }
  let(:like_item) { ".likes-info a.like.fi-heart" }

  scenario "Visitor sees post" do
    visit post_path(post)

    expect(page).to have_content("Winter is coming.")
    expect(page).to have_content("Hodor! Hodor.")

    expect(page).not_to have_selector(like_item)
    expect(page).to have_css(likes_counter, text: post.likes.count)
  end
end
