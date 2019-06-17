module Posts
  class FetchQuery < Posts::BaseQuery
    def all
      sort(fetch_posts).page(page_number).per(SearchController::PAGES_NUM)
    end

    private

    def fetch_posts
      relation
        .where(user: params[:author])
        .includes(:likes)
        .with_likes
    end

    def sort(posts)
      posts
        .ransack(order_params).result
        .order(order_params)
    end

    def order_params
      params[:ransack_order_by] || "created_at desc"
    end

    def page_number
      params[:page] || 1
    end
  end
end
