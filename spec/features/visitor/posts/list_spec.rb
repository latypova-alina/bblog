require "rails_helper"

feature "List Posts" do
  let(:post) { create :post, title: "Winter is coming." }

  before do
    create :post, title: "Hodor! Hodor."
    create_list :like, 5, post: post
  end

  scenario "Visitor sees posts list" do
    visit posts_path

    expect(page).to have_content("Winter is coming.")
    expect(page).to have_content("Hodor! Hodor.")
    expect(page).to have_content(0)
    expect(page).to have_content(5)
  end
end
