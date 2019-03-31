module Posts
  class BaseQuery
    attr_reader :relation, :options

    def initialize(options = {})
      @relation = Post.extending(Scopes)
      @options = options
    end
  end
end
