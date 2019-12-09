require "rails_helper"
require "rspec_api_documentation/dsl"

resource "Post Like" do
  let(:post) { create :post }
  let(:post_id) { post.id }

  def expected_responce_body(like_id)
    {
      "data" => {
        "id" => like_id.to_s,
        "type" => "likes",
        "attributes" => {
          "user_id" => current_user.id
        },
        "relationships" => {
          "post" => {
            "data" => {
              "id" => post.id.to_s,
              "type" => "posts"
            }
          }
        }
      },
      "included" => [
        {
          "id" => post.id.to_s,
          "type" => "posts",
          "attributes" => {
            "title" => post.title,
            "content" => post.content,
            "likes_count" => post.likes.count
          }
        }
      ]
    }
  end

  post "/api/v1/posts/:post_id/likes" do
    include_context "current user signed in"

    example "Create a new Like [success]" do
      do_request

      expect(post.likes.count).to eq(1)
      expect(response_status).to eq(200)
      expect(json_response_body).to eq(expected_responce_body(Like.all.first.id))
    end

    context "when user is not authorized" do
      before { logout }

      example "Create a new Like [error] - Create a like with no access" do
        do_request

        expect(response_status).to eq(401)
      end
    end
  end

  delete "/api/v1/posts/:post_id/likes/:id" do
    let(:like) { create :like, post: post }
    let(:id) { like.id }

    include_context "current user signed in"

    let(:like) { create :like, post: post, user: current_user }

    example "Delete a Like [success]" do
      do_request

      expect(post.likes.count).to eq(0)
      expect(response_status).to eq(200)
      expect(json_response_body).to eq(expected_responce_body(id))
    end

    context "when user is not authorized" do
      before { logout }

      example "Delete a Like [error] - Delete a like with no access" do
        do_request

        expect(response_status).to eq(401)
      end
    end
  end
end
