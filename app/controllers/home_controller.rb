class HomeController < ApplicationController
  def index
    @categories = Category.includes(:articles).order(priority: :desc)
    @featured_article = Article.find(Vote.group(:article_id).count.max_by { |_a, v| v }.first) unless Vote.all.empty?
  end
end
