require "rails_helper"

feature "List Posts" do
  let(:first_post) { create :post, title: "Winter is coming." }
  let!(:second_post) { create :post, title: "Hodor! Hodor." }

  before { create_list :like, 5, post: first_post }

  scenario "Visitor sees posts list" do
    visit posts_path

    expect(page).to have_content("Winter is coming.")
    expect(page).to have_content("Hodor! Hodor.")

    expect(page).to have_css(".post##{first_post.id} .like.fi-heart", text: 5)
    expect(page).to have_css(".post##{second_post.id} .like.fi-heart", text: 0)
  end
end
