module Posts
  class FetchQuery
    DEFAULT_ORDER = "created_at desc".freeze
    DEFAULT_PAGE = 1

    attr_reader :params

    def initialize(params)
      @params = params
    end

    def all
      sort(fetch_posts)
        .page(page_number)
        .per(SearchController::PER_PAGE_LIMIT)
        .order(order_params)
    end

    private

    def order_param
      # if there was a sorting query then params[:q] is filled.
      # example of params[:q]: <ActionController::Parameters { "s"=>"likes_count desc" } permitted: false>

      params[:q] ? params[:q][:s] : nil
    end

    def fetch_posts
      return Post.all unless author

      Post.where(user: author)
    end

    def sort(posts)
      posts.ransack(order_params).result.preload(:likes)
    end

    def author
      params[:author].presence
    end

    def order_params
      order_param || DEFAULT_ORDER
    end

    def page_number
      params[:page] || DEFAULT_PAGE
    end
  end
end
