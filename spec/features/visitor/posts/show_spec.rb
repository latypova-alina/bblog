require "rails_helper"

feature "Show Post" do
  let(:post) do
    create :post, :with_likes, title: "Winter is coming.", content: "Hodor! Hodor."
  end

  scenario "Visitor sees post" do
    visit post_path(post)

    expect(page).to have_content("Winter is coming.")
    expect(page).to have_content("Hodor! Hodor.")

    expect(page).not_to have_selector("a.like")
    expect(page).to have_content(post.likes.count)
  end
end
