class AdminController < ApplicationController
  before_action :require_admin

  def show
    @orders = Order.sorted_orders
  end

  def ship_order
    order= Order.find(params[:order])
    order.update(status: 'shipped')
    render :show
  end

end
