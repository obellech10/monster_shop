class MerchantController < ApplicationController
  before_action :require_merchant_admin

  def show
    @merchant = Merchant.find(current_user.merchant_id)
    @orders = Order.all
  end

end
