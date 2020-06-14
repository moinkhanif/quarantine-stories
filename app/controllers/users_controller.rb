class UsersController < ApplicationController
  def new
    # all_categories
  end

  def create
    @user = User.new(user_params)
    @user.name.downcase!
    if @user.save
      flash[:notice] = 'Successfully created your account!'
    else
      flash[:alert] = 'Failed to create account. Try again!'
    end
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit(:name)
  end
end
