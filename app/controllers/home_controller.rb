class HomeController < ApplicationController
  def index
    @categories = Category.order(priority: :desc)
    @featured_article = Article.find(Vote.group(:article_id).count.max_by { |_a, v| v }.first)
  end
end
