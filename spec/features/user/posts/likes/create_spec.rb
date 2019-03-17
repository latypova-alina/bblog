require "rails_helper"

feature "Create like for post" do
  include_context "current user signed in"

  let(:post) do
    create :post, title: "Winter is coming.", content: "Hodor! Hodor."
  end

  let(:like_item) { "a.like.fi-heart" }
  let(:picked_like_item) { "a.like.fi-heart.picked" }

  scenario "Visitor likes the post", js: true do
    visit post_path(post)

    expect(page).to have_selector(like_item)
    expect(page).not_to have_selector(picked_like_item)

    find(like_item).trigger("click")

    expect(page).to have_selector(picked_like_item)
    expect(post.likes.count).to eq(1)
  end
end
