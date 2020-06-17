class CategoryController < ApplicationController
  def show
    @category = Category.includes(:articles).find(params[:id])
    @articles = @category.articles.joins('LEFT JOIN User on id = articles.user_id').order('articles DESC').includes(:votes, :user)
  end

  def new; end

  def create
    @category = Category.new(category_params)
    @category.name.capitalize!
    if @category.save
      flash[:notice] = "#{@category.name} was created successfully!"
    else
      flash[:alert] = "Unable to create category #{@category.name}!"
    end
    redirect_to root_path
  end

  def category_params
    params.require(:category).permit(:name, :priority)
  end
end
