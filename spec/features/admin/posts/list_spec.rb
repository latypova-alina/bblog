require "rails_helper"

feature "List Posts" do
  include_context "admin signed in"

  let(:author_selector_options) do
    page.all("select#q_user_id option").map(&:text)
  end

  before do
    create :user, full_name: "John the Reader"

    3.times do |i|
      create(:user, :author, full_name: "John the Author #{i}") do |author|
        create :post, user: author, title: "Cool Post #{i}"
      end
    end
  end

  scenario "Admin lists posts" do
    visit admin_posts_path

    expect(page).to have_content("Cool Post 0")
    expect(page).to have_content("Cool Post 1")
    expect(page).to have_content("Cool Post 2")
  end

  scenario "Admin filters posts by author" do
    visit admin_posts_path

    3.times { |i| expect(author_selector_options).to have_content("John the Author #{i}") }
    expect(author_selector_options).not_to have_content("John the Reader")

    select "John the Author 1", from: "q_user_id"
    click_on "Filter"

    expect(page).to have_content("Cool Post 1")
    expect(page).not_to have_content("Cool Post 0")
    expect(page).not_to have_content("Cool Post 2")
  end
end
