class UsersController < ApplicationController
  def register
  end

  def create
    user = User.create(user_params)
    flash[:success] = "#{user.name} is now registered and logged in!"
    redirect_to profile_path
  end

  def show

  end

  private

  def user_params
    params.permit(:name, :address, :city, :state, :zip, :user_name, :password)
  end
end
