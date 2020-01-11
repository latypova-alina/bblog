module Author
  class PostsController < Author::BaseController
    expose_decorated :post
    expose_decorated :posts, :fetch_posts

    def new
    end

    def create
      post.save

      respond_with(post)
    end

    def edit
    end

    def update
      post.update(post_params)

      respond_with(post)
    end

    def destroy
      post.destroy

      respond_with(:author, post)
    end

    private

    def fetch_posts
      Posts::FetchQuery.new(Post.all, query_params).all
    end

    def authorize_resource!
      authorize!(post, with: Author::PostPolicy)
    end

    def post_params
      params.require(:post).permit(:title, :content, :image)
            .merge(user: current_user)
    end

    def query_params
      {
        author: current_user,
        page: params[:page]
      }
    end
  end
end
