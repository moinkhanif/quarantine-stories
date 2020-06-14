class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.where(name: user_params[:name].downcase).first
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "Successfully logged in as #{@user.name.capitalize}"
    else
      flash[:alert] = 'Name does not exist! Please try again or sign up'
    end
    redirect_to root_path
  end

  def destroy
    if logged_in?
      session[:user_id] = nil
      flash[:notice] = 'Successfully logged out!'
    else
      flash[:alert] = 'User not logged in!'
    end
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit(:name)
  end
end
