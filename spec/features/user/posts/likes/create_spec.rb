require "rails_helper"

feature "Create like for post" do
  include_context "current user signed in"

  let(:post) { create :post }

  let(:like_item) { ".likes-info a.like.fi-heart" }
  let(:picked_like_item) { ".likes-info a.like.fi-heart.picked" }
  let(:likes_counter) { ".likes-info .likes-count" }

  scenario "Visitor likes the post", js: true do
    visit post_path(post)

    expect(page).to have_selector(like_item)
    expect(page).not_to have_selector(picked_like_item)
    expect(page).to have_css(likes_counter, text: "0")

    find(like_item).trigger("click")

    expect(page).to have_selector(picked_like_item)
    expect(page).to have_css(likes_counter, text: "1")
  end
end
