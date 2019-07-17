class AdminController < ApplicationController
  def show
    if !current_user.nil? && current_user.admin? && !current_user.merchant?
      render :show
    else
      render file: "/public/404", status: 404
    end
  end
end
