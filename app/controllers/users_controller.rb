class UsersController < ApplicationController
  def register
    @user = User.new
  end

  def login
    if current_admin?
      redirect_to admin_dashboard_path
      flash[:success] = "#{current_user.name} is logged in."
    elsif current_merchant?
      redirect_to merchant_dashboard_path
      flash[:success] = "#{current_user.name} is logged in."
    elsif current_user
      redirect_to profile_path
      flash[:success] = "#{current_user.name} is logged in."
    end
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
