class MerchantController < ApplicationController
  before_action :require_merchant_admin

  def show
    @merchant = Merchant.find(current_user.merchant_id)
    @orders = Order.all
  end

  def order_show
    @merchant = Merchant.find(current_user.merchant_id)
    @order = Order.find(params[:id])
  end

  # def order_fulfillment
  #   order_item = OrderItem.find(params[:id])
  #   order_item.fulfill
  #   flash[:notice] = "This item has been fulfilled."
  #   redirect_to merchant_order_show_path
  # end

end
