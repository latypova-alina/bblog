require "rails_helper"

describe Posts::FetchQuery do
  describe "#all" do
    let(:posts_amount) { posts_per_page + 1 }
    let(:posts_per_page) { SearchController::PER_PAGE_LIMIT }
    let(:result_posts) { described_class.new(Post.all, params).all }

    let(:author) { create :user, :author }
    let!(:authors_post) { create :post, user: author }

    let(:params) { {} }

    before { posts_amount.times { create :post } }

    it "returns only PER_PAGE_LIMIT amount of posts" do
      expect(result_posts.count).to eq posts_per_page
    end

    context "when author param is passed" do
      let(:params) { { author: author } }

      it "returns only authors posts" do
        expect(result_posts.count).to eq(1)
        expect(result_posts.first).to eq(authors_post)
      end
    end
  end
end
