class ApplicationController < ActionController::Base
  def five_categories
    Category.all.limit(5)
  end

  def all_categories
    Category.all
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      false
    end
  end

  def login_required
    unless logged_in?
      flash[:alert] = 'You need to login first!'
      redirect_to login_path
    end
  end

  def logged_in?
    current_user != false
  end

  helper_method :five_categories, :current_user, :logged_in?, :all_categories
end
