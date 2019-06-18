module Posts
  class FetchQuery < Posts::BaseQuery
    DEFAULT_ORDER = "created_at desc"
    DEFAULT_PAGE = 1

    def all
      sort(fetch_posts)
        .page(page_number)
        .per(SearchController::PAGES_NUM)
        .order(order_params)
    end

    private

    def fetch_posts
      relation
        .where(user: params[:author])
        .includes(:likes)
        .with_likes
    end

    def sort(posts)
      posts.ransack(order_params).result
    end

    def order_params
      params[:ransack_order_by] || DEFAULT_ORDER
    end

    def page_number
      params[:page] || DEFAULT_PAGE
    end
  end
end
