require "rails_helper"

feature "Search" do
  before do
    create(:user, :author, full_name: "Hodus Maximus").tap do |user|
      create :post, title: "Hodor? Hodor.", content: "Winter is coming.", user: user
    end
  end

  context "when records match" do
    scenario "visitor can search through posts and authors" do
      visit root_path

      fill_in :search_param, with: "hod"

      click_button "Search"

      expect(page).to have_content("Hodor? Hodor.")
      expect(page).to have_content("Winter is coming.")
      expect(page).to have_content("Hodus Maximus")
    end
  end

  context "when records do not match" do
    scenario "visitor does not see posts" do
      visit root_path

      fill_in :search_param, with: "max"

      click_button "Search"

      expect(page).to have_content("No posts were found")
      expect(page).not_to have_content("Hodor? Hodor.")
    end

    scenario "visitor does not see authors" do
      visit root_path

      fill_in :search_param, with: "abs"

      click_button "Search"

      expect(page).to have_content("No authors were found")
      expect(page).not_to have_content("Hodus Maximus")
    end
  end
end
