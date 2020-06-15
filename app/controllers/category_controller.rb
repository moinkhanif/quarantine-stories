class CategoryController < ApplicationController
  def show
    @category  = Category.find(params[:id])
  end
  def category_params
    params.require(:id).permit(:id)
  end
end
