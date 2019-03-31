module Posts
  class FetchQuery < Posts::BaseQuery
    def all
      sort(fetch_posts).page(page_number).per(4)
    end

    private

    def fetch_posts
      Post
        .where(user: options[:author] || any_user)
        .includes(:likes)
        .with_likes
    end

    def sort(posts)
      posts
        .ransack(order_by_params).result
        .ransack_order(order_by_params)
    end

    def any_user
      User.all
    end

    def order_by_params
      options[:ransack_order_by] || "created_at desc"
    end

    def page_number
      options[:page] || 1
    end
  end
end
