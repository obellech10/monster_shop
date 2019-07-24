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
    order_item = OrderItem.where(item_id: params[:item_id], order_id: params[:id]).first
    item = order_item.item
    item.update(inventory: item.inventory - order_item.quantity)
    order_item.update(fulfilled: true)
    redirect_to merchant_order_show_path(params[:id])
  end

end
