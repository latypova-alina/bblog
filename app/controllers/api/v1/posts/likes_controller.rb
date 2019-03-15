module Api
  module V1
    module Posts
      class LikesController < Api::V1::BaseController
        expose :post
        expose :like, -> { Like.new(post: post, user: current_user) }

        def create
          respond_with_resource(like, location: posts_path) if save_like.success?
        end

        private

        def save_like
          @save_like ||= Likes::Save.call(like: like)
        end
      end
    end
  end
end
