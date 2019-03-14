module Api
  module V1
    class LikesController < Api::V1::BaseController
      expose :post, :find_post
      expose :like, -> { Like.new(post: post, user: current_user) }

      def create
        if save_like.success?
          respond_with_resource(like, location: posts_path)
        else
          respond_with_error(save_like.error_code, save_like.error_message)
        end
      end

      private

      def find_post
        Post.find(params[:post_id])
      end

      def save_like
        @save_like ||= Likes::Save.call(like: like)
      end
    end
  end
end
