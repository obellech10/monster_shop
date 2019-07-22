class MerchantController < ApplicationController
  before_action :require_merchant_admin

  def show
    @merchant = Merchant.find(current_user.merchant_id)
    @pending_orders = Order.pending_merchant_orders(@merchant)
  end
end
