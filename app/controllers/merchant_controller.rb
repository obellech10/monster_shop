class MerchantController < ApplicationController
  before_action :require_merchant

  def show
    unless current_user && current_user.merchant?
      render file: "/public/404", status: 404
    else
      render :show
    end
  end

end
