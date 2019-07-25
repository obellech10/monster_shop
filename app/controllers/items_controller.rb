class ItemsController < ApplicationController
  def index
    if params[:merchant_id]
      @merchant = Merchant.find(params[:merchant_id])
      @items = @merchant.items
    else
      @items = Item.all
    end
    @top_five = Item.top_five
    @bottom_five = Item.bottom_five
  end

  def show
    @item = Item.find(params[:id])
  end
end
