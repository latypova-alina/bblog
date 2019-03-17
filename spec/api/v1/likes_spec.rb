require "rails_helper"
require "rspec_api_documentation/dsl"

resource "Post Like" do
  let(:post) { create :post }
  let(:post_id) { post.id }

  def expected_responce_body(like_id)
    { "data" =>
        {
          "id" => like_id.to_s,
          "type" => "likes",
          "attributes" => {
            "post_id" => post.id,
            "user_id" => current_user.id
          }
        } }
  end

  post "/api/v1/posts/:post_id/likes" do
    context "when user is not authorized" do
      example "Create Like" do
        do_request

        expect(response_status).to eq(401)
      end
    end

    context "when user is authorized" do
      include_context "current user signed in"

      example "Create Like" do
        do_request

        expect(post.likes.count).to eq(1)
        expect(response_status).to eq(200)
        expect(json_response_body).to eq(expected_responce_body(Like.all.first.id))
      end
    end
  end

  delete "/api/v1/posts/:post_id/likes/:id" do
    let(:like) { create :like, post: post }
    let(:id) { like.id }

    context "when user is not authorized" do
      example "Delete Like" do
        do_request

        expect(response_status).to eq(401)
      end
    end

    context "when user is authorized" do
      include_context "current user signed in"

      let(:like) { create :like, post: post, user: current_user }

      example "Delete Like" do
        do_request

        expect(post.likes.count).to eq(0)
        expect(response_status).to eq(200)
        expect(json_response_body).to eq(expected_responce_body(id))
      end
    end
  end
end
