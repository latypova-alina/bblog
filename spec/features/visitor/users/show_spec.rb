require "rails_helper"

feature "Show User" do
  let(:author) { create :user, :author, :with_avatar, full_name: "John Smith", about_info: "I'm a cool author!" }

  before do
    create :post, title: "Some Post"
    create :post, user: author, title: "Authors Post"
  end

  scenario "Visitor sees Users page" do
    visit user_path(author)

    expect(page).to have_content("John Smith")
    expect(page).to have_content("I'm a cool author!")
    expect(page).to have_content("Authors Post")
    expect(page).not_to have_content("Some Post")
  end
end
