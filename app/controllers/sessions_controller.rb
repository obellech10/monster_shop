class SessionsController < ApplicationController
  def create
    user = User.find_by(user_name: params[:user_name])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "#{user.name} is logged in."
      redirect_to profile_path
    else
      redirect_to login_path
    end
  end
end
