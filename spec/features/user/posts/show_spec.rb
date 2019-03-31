require "rails_helper"

feature "Show Post" do
  include_context "current user signed in"

  let(:post) do
    create :post, title: "Winter is coming.", content: "Hodor! Hodor."
  end

  before do
    create_list :like, 10, post: post
  end

  scenario "Visitor sees post" do
    visit post_path(post)

    expect(page).to have_content("Winter is coming.")
    expect(page).to have_content("Hodor! Hodor.")

    expect(page).to have_selector("a.like")
    expect(page).to have_content(10)
  end
end
