class MerchantController < ApplicationController
  def show
    if !current_user
      render file: "/public/404", status: 404
    end
  end
end
