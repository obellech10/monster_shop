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
  end

  def logout
    session.delete(:cart)
    flash[:success] = "#{current_user.name} is now logged out!"
    session[:user_id] = nil
    redirect_to home_path
  end

  private

  def user_params
    params.permit(:name, :address, :city, :state, :zip, :user_name, :password)
  end
end
