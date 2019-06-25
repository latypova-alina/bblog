require "rails_helper"

feature "List Posts" do
  let(:post) { create :post, id: 1, title: "Winter is coming." }

  before do
    create :post, id: 2, title: "Hodor! Hodor."
    create_list :like, 5, post: post
  end

  scenario "Visitor sees posts list" do
    visit posts_path

    expect(page).to have_content("Winter is coming.")
    expect(page).to have_content("Hodor! Hodor.")
    expect(page).to have_css(".post#1 .like.fi-heart", text: 5)
    expect(page).to have_css(".post#2 .like.fi-heart", text: 0)
  end
end
