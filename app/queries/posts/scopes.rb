module Posts::Scopes
  def with_likes
    left_joins(:likes).group(:id).select("posts.*, count(likes.id) as likes_count")
  end
end
