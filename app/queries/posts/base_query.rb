module Posts
  class BaseQuery
    attr_reader :relation, :params

    def initialize(params = {})
      @relation = Post.extending(Scopes)
      @params = query_params(params)
    end

    private

    def query_params(params)
      {
        "ransack_order_by": order_param(params),
        "author": params[:author] || any_user
      }
    end

    def order_param(params)
      params[:q] ? params[:q][:s] : nil
    end

    def any_user
      User.all
    end
  end
end
