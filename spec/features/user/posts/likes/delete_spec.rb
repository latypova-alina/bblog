require "rails_helper"

feature "Delete like for post" do
  include_context "current user signed in"

  let(:post) { create :post }

  let(:like_item) { "a.like.fi-heart" }
  let(:picked_like_item) { "a.like.fi-heart.picked" }

  before do
    create :like, post: post, user: current_user
  end

  scenario "Visitor likes the post", js: true do
    visit post_path(post)

    expect(page).to have_selector(picked_like_item)

    find(picked_like_item).trigger("click")

    expect(page).to have_selector(like_item)
    expect(page).not_to have_selector(picked_like_item)
    expect(post.reload.likes).to be_empty
  end
end
