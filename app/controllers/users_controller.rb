class UsersController < ApplicationController
  def index
    @order = current_user.orders
  end

  def register
    @user = User.new
  end

  def login
    if current_admin?
      redirect_to admin_dashboard_path
      flash[:success] = "#{current_user.name} is logged in."
    elsif current_merchant_admin?
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
      session[:user_id] = @user.id
      flash[:success] = "#{@user.name} is now registered and logged in!"
      redirect_to profile_path
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      render :register
    end
  end

  def show
    unless current_user && current_user.default?
      render file: "/public/404", status: 404
    else
      render :show
    end
  end

  def edit
    @user = current_user
  end

  def edit_password
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(update_params)
      flash[:success] = "User profile has been updated!"
      redirect_to profile_path
    else
      flash[:error] = "That email is already in use, please enter valid email"
      render :edit
    end
  end

  def update_password
    @user = current_user
    @user.update(update_params)
    flash[:success] = "Your password has been updated."
    redirect_to profile_path
  end

  def logout
    session.delete(:cart)
    flash[:success] = "#{current_user.name} is now logged out!"
    session[:user_id] = nil
    redirect_to home_path
  end

  def order_show
    @order = current_user.orders.find(params[:id])
  end

  def order_cancel
    order = current_user.orders.find(params[:id])
    order.update(status: "cancelled")

    order.order_items.each do |order_item|
      order_item.cancel
    end

    flash[:success] = "Order #{order.id} has been cancelled."
    redirect_to profile_orders_path
  end

  private

  def user_params
    params.permit(:name, :address, :city, :state, :zip, :user_name, :password)
  end

  def update_params
    params.require(:user).permit(:name, :address, :city, :state, :zip, :user_name, :password)
  end
end
