class AdminController < ApplicationController
  before_action :require_admin

  def show
    @orders = Order.sorted_orders
  end
end
