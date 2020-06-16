class ArticleController < ApplicationController
  def create
    @article = Article.new(article_params)
    @article[:user_id] = current_user.id
    if @article.save
      flash[:notice] = 'Article created successfully!'
    else
      flash[:alert] = "COULD NOT!#{@article.user_id}#{@article.title}#{@article.body}"
    end
    redirect_to root_path
  end

  def article_params
    params.require(:article).permit(:title, :body, :category_id, :image)
  end
end
