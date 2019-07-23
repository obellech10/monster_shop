class Admin::MerchantsController < Admin::BaseController
  def index
    @merchants = Merchant.all
  end

  def show
  end

  def disable
    merchant = Merchant.find(params[:id])
    merchant.update(enabled: false)
    # merchant.save
    flash[:success] = "#{merchant.name}'s account is now disabled."
    redirect_to admin_merchants_path
  end
end
