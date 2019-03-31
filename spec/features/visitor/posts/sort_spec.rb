require "rails_helper"

feature "Sort Posts" do
  let(:next_page) { find("a", text: "Next ›")}
  let(:prev_page) { find("a", text: "‹ Prev")}

  def check_first_four_posts
    4.times do |i|
      expect(page).to have_content("Post Title #{i}")
      expect(page).not_to have_content("Post Title #{i + 4}")
    end
  end

  def check_last_four_posts
    4.times do |i|
      expect(page).to have_content("Post Title #{i + 4}")
      expect(page).not_to have_content("Post Title #{i}")
    end
  end

  before :all do
    8.times do |i|
      create(:post, title: "Post Title #{i}", created_at: Date.new - i.day).tap do |post|
        create_list :like, i, post: post
      end
    end
  end

  context "Sort by Creation Date" do
    let(:date_sort) { find("a", text: "Creation Date") }

    scenario "Visitor sees sorted posts" do
      visit posts_path
      date_sort.click

      check_last_four_posts
      next_page.click
      check_first_four_posts

      prev_page.click
      date_sort.click

      check_first_four_posts
      next_page.click
      check_last_four_posts
    end
  end

  context "Sort by Title" do
    let(:title_sort) { find("a", text: "Title") }

    scenario "Visitor sees sorted posts" do
      visit posts_path
      title_sort.click

      check_first_four_posts
      next_page.click
      check_last_four_posts

      prev_page.click
      title_sort.click

      check_last_four_posts
      next_page.click
      check_first_four_posts
    end
  end

  context "Sort by Likes Count" do
    let(:likes_sort) { find("a", text: "Likes") }

    scenario "Visitor sees sorted posts" do
      visit posts_path
      likes_sort.click

      check_first_four_posts
      next_page.click
      check_last_four_posts

      prev_page.click
      likes_sort.click

      check_last_four_posts
      next_page.click
      check_first_four_posts
    end
  end
end
