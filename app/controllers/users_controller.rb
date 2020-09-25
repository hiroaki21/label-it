class UsersController < ApplicationController
  before_action :set_login, only: [:edit, :update]

  def edit
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      redirect_to root_path
    else
      redirect_to edit_user_path(current_user)
    end
  end

  private

  def set_login
    redirect_to '/login' unless user_signed_in?
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
