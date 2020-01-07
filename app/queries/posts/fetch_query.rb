module Posts
  class FetchQuery
    DEFAULT_PAGE = 1

    attr_reader :posts, :params

    def initialize(posts, params)
      @posts = posts
      @params = params
    end

    def all
      author ? posts.where(user: author) : posts
        .page(page_number)
        .per(SearchController::PER_PAGE_LIMIT)
    end

    private

    def author
      params[:author].presence
    end

    def page_number
      params[:page] || DEFAULT_PAGE
    end
  end
end
