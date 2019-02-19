require "rails_helper"

feature "List Posts" do
  before do
    create :post, title: "Winter is coming."
    create :post, title: "Hodor! Hodor."
  end

  scenario "Visitor sees posts list" do
    visit posts_path

    expect(page).to have_content("Winter is coming.")
    expect(page).to have_content("Hodor! Hodor.")
  end
end
