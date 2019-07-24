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

  def order_item_fulfillment
    order_item = Order.find(params[:id]).order_items.first
    order_item.fulfill
    redirect_to merchant_dashboard_path
  end

end
