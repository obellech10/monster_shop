class Admin::MerchantsController < Admin::BaseController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
    @orders = Order.all
  end

  def disable
    merchant = Merchant.find(params[:id])
    merchant.update(enabled: false)
    flash[:success] = "#{merchant.name}'s account is now disabled."
    redirect_to admin_merchants_path
  end

  def enable
    merchant = Merchant.find(params[:id])
    merchant.update(enabled: true)
    flash[:success] = "#{merchant.name}'s account is now enabled."
    redirect_to admin_merchants_path
  end
end
