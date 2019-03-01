require "rails_helper"

feature "List Posts" do
  include_context "admin signed in"

  before { 3.times{ |i| create :post, title: "Cool Post #{i}" } }

  scenario "Admin lists posts" do
    visit admin_posts_path

    expect(page).to have_content("Cool Post 0")
    expect(page).to have_content("Cool Post 1")
    expect(page).to have_content("Cool Post 2")
  end
end
