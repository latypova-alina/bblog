module Author
  class PostsController < Author::BaseController
    expose :post
    expose :posts, :fetch_posts

    def new
    end

    def create
      post.save

      respond_with(:author, post)
    end

    def edit
    end

    def update
      post.update(post_params)

      respond_with(:author, post)
    end

    def index
    end

    private

    def fetch_posts
      Post.where(user: current_user)
    end

    def authorize_resource!
      authorize!(post, with: Author::PostPolicy)
    end

    def post_params
      params.require(:post).permit(:title, :content, :image)
            .merge(user: current_user)
    end
  end
end
