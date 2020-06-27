class ArticleController < ApplicationController
  before_action :login_required, only: %i[new create destroy]
  def new; end

  def create
    @article = Article.new(article_params)
    @article[:user_id] = current_user.id
    if @article.save
      flash[:notice] = 'Article created successfully!'
    else
      flash[:alert] = 'Failed to create article please try again!'
    end
    redirect_to root_path
  end

  def article_params
    params.require(:article).permit(:title, :body, :category_id, :image)
  end
end
