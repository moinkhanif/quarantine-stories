class ApplicationController < ActionController::Base
  def all_categories
    Category.all
  end

  helper_method :all_categories
end
