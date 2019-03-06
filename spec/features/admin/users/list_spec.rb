require "rails_helper"

feature "List Users" do
  include_context "admin signed in"

  before do
    create :user, full_name: "John the Reader"
    create :user, :author, full_name: "John the Author"
  end

  scenario "Admin lists users" do
    visit admin_users_path

    expect(page).to have_content("John the Reader")
    expect(page).to have_content("John the Author")
  end

  scenario "Admin filters users by role" do
    visit admin_users_path

    select "reader", from: "q_role"
    click_on "Filter"

    expect(page).to have_content("John the Reader")
    expect(page).not_to have_content("John the Author")
  end
end
