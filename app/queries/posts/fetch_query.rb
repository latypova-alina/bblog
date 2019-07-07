module Posts
  class FetchQuery
    DEFAULT_ORDER = "created_at desc"
    DEFAULT_PAGE = 1

    attr_reader :params

    def initialize(params = {})
      @params = query_params(params)
    end

    def all
      sort(fetch_posts)
        .page(page_number)
        .per(SearchController::PER_PAGE_LIMIT)
        .order(order_params)
    end

    private

    def query_params(params)
      {
        ransack_order_by: order_param(params),
        author: params[:author] || any_user
      }
    end

    def order_param(params)
      #if there was a sorting query then params[:q] is filled.
      #example of params[:q]: <ActionController::Parameters {"s"=>"likes_count desc"} permitted: false>
      params[:q] ? params[:q][:s] : nil
    end

    def any_user
      User.all
    end

    def fetch_posts
      Post.extending(Scopes)
        .where(user: params[:author])
        .with_likes
    end

    def sort(posts)
      posts.ransack(order_params).result.includes(:likes)
    end

    def order_params
      params[:ransack_order_by] || DEFAULT_ORDER
    end

    def page_number
      params[:page] || DEFAULT_PAGE
    end
  end
end
