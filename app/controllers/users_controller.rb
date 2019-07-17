class UsersController < ApplicationController
  def register
    @user = User.new
  end

  def login
  end

  def create
    @user = User.create(user_params)
    if @user.save
      flash[:success] = "#{@user.name} is now registered and logged in!"
      redirect_to profile_path
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      render :register
    end
  end

  def show
    if !current_user.nil? && current_user.default? && !current_user.merchant?
      render :show
    else
      render file: "/public/404", status: 404
    end
  end

  private

  def user_params
    params.permit(:name, :address, :city, :state, :zip, :user_name, :password)
  end
end
