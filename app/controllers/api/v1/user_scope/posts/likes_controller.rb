module Api
  module V1
    module UserScope
      module Posts
        class LikesController < Api::V1::UserScope::BaseController
          expose :post
          expose :like, :fetch_like

          def create
            save_like = Likes::Save.call(like: like)

            if save_like.success?
              respond_with_resource(like, location: posts_path)
            else
              respond_with_error(save_like.error_code, save_like.error_message)
            end
          end

          def destroy
            destroy_like = Likes::Destroy.call(like: like)

            if destroy_like.success?
              respond_with_resource(like, location: posts_path)
            else
              respond_with_error(destroy_like.error_code, destroy_like.error_message)
            end
          end

          private

          def fetch_like
            Like.find_by(post: post, user: current_user) || Like.new(post: post, user: current_user)
          end
        end
      end
    end
  end
end
