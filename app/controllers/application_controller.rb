class ApplicationController < ActionController::Base
  def all_categories
    Category.all
  end

  def current_user
    if session[:user_id]
      User.find(session[:user_id])
    else
      false
    end
  end

  def logged_in?
    !!current_user
  end

  helper_method :all_categories, :current_user, :logged_in?
end
