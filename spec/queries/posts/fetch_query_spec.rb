require "rails_helper"

describe Posts::FetchQuery do
  describe "#all" do
    let(:posts_amount) { posts_per_page + 1 }
    let(:posts_per_page) { SearchController::PER_PAGE_LIMIT }

    context "when there is NO order param" do
      subject { described_class.new(params).all.pluck(:created_at).map(&:year) }

      let(:params) { {} }
      let(:expected_result) { [2004, 2003, 2002, 2001] }

      before { posts_amount.times { |i| Timecop.freeze(Time.zone.local(2000 + i, 2)) { create(:post) } } }
      after { Timecop.return }

      it { is_expected.to match_array(expected_result) }
    end

    context "when sorting field is title" do
      subject { described_class.new(params).all.pluck(:title) }

      before { posts_amount.times { |i| create(:post, title: "Post Title #{i}") } }

      let(:params) { { q: { s: "title desc" } } }
      let(:expected_result) do
        [
          "Post Title 4",
          "Post Title 3",
          "Post Title 2",
          "Post Title 1"
        ]
      end

      it { is_expected.to match_array(expected_result) }

      context "and the order is ascending" do
        let(:params) { { q: { s: "title asc" } } }
        let(:expected_result) do
          [
            "Post Title 0",
            "Post Title 1",
            "Post Title 2",
            "Post Title 3"
          ]
        end

        it { is_expected.to match_array(expected_result) }
      end
    end

    context "when sorting param is date" do
      subject { described_class.new(params).all.pluck(:created_at).map(&:year) }

      before { posts_amount.times { |i| Timecop.freeze(Time.zone.local(2000 + i, 2)) { create(:post) } } }

      after { Timecop.return }

      let(:params) { { q: { s: "created_at desc" } } }
      let(:expected_result) { [2004, 2003, 2002, 2001] }

      it { is_expected.to match_array(expected_result) }

      context "and the order is ascending" do
        let(:params) { { q: { s: "created_at asc" } } }
        let(:expected_result) { [2000, 2001, 2002, 2003] }

        it { is_expected.to match_array(expected_result) }
      end
    end

    context "when sorting param is likes_count" do
      subject { described_class.new(params).all.map { |post| post.likes.size } }

      before { posts_amount.times { |i| create(:post).tap { |post| create_list :like, i, post: post } } }

      let(:params) { { q: { s: "likes_count desc" } } }
      let(:expected_result) { [4, 3, 2, 1] }

      it { is_expected.to match_array(expected_result) }

      context "and the order is ascending" do
        let(:params) { { q: { s: "likes_count asc" } } }
        let(:expected_result) { [0, 1, 2, 3] }

        it { is_expected.to match_array(expected_result) }
      end
    end
  end
end
