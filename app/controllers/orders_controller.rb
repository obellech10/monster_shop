class OrdersController < ApplicationController
  def new
  end

  def create
    user = current_user
    @order = user.orders.new(order_params)
    if @order.save
      cart.items.each do |item|
        @order.order_items.create({
          item: item,
          quantity: cart.count_of(item.id),
          price: item.price
          })
      end
      flash[:notice] = "Your order has been created."
      session.delete(:cart)
      redirect_to "/profile/orders"
    else
      flash[:notice] = "Please complete address form to create an order."
      render :new
    end
  end

  private

  def order_params
    params.permit(:status)
  end
end
