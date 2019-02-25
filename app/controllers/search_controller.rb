class SearchController < ApplicationController
  expose :search_param, :search_param
  expose_decorated :posts, :fetch_posts
  expose_decorated :authors, :fetch_authors, decorator: UserDecorator

  def index
  end

  private

  def fetch_posts
    Post.search(search_param).page(params[:page]).per(4)
  end

  def search_param
    params[:search][:param] if params[:search]
  end

  def fetch_authors
    User.authors.search(search_param).page(params[:page]).per(4)
  end
end
