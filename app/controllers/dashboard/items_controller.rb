class Dashboard::ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(current_user.merchant_id)
    @items = @merchant.items
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    flash[:notice] = "#{item.name} has been deleted"
    redirect_to dashboard_items_path
  end
end
