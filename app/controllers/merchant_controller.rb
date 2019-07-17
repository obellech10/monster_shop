class MerchantController < ApplicationController
  def show
    if !current_user || current_user.default?
      render file: "/public/404", status: 404
    end
  end
end
