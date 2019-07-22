class SessionsController < ApplicationController
  def create
    user = User.find_by(user_name: params[:user_name])
    if user.admin? && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "#{user.name} is logged in."
      redirect_to "/admin"
    elsif user.merchant_admin? && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "#{user.name} is logged in."
      redirect_to "/merchant"
    elsif user.default? && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "#{user.name} is logged in."
      redirect_to profile_path
    else
      flash[:error] = "Incorrect user name or password"
      redirect_to login_path
    end
  end
end
