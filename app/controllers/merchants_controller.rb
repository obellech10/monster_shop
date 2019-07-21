class MerchantsController < ApplicationController

  def index
    @merchants = User.all.where(role: 2)
  end

  def show
    @merchant = User.find(params[:id])
  end

  # def new
  # end

  # def create
  #   merchant = Merchant.new(merchant_params)
  #   if merchant.save
  #     redirect_to '/merchants'
  #   else
  #     generate_flash(merchant)
  #     render :new
  #   end
  # end


  # def edit
  #   @merchant = User.find(params[:id]).where(role: 2)
  # end

  # def update
  #   @merchant = Merchant.find(params[:id])
  #   if @merchant.update(merchant_params)
  #     redirect_to "/merchants/#{@merchant.id}"
  #   else
  #     generate_flash(@merchant)
  #     render :edit
  #   end
  # end

  # def destroy
  #   merchant = User.find(params[:id]).where(role: 2)
  #   if merchant.order_items.empty?
  #     merchant.destroy
  #   else
  #     flash[:notice] = "#{merchant.name} can not be deleted - they have orders!"
  #   end
  #   redirect_to '/merchants'
  # end

  private

  # def merchant_params
  #   params.permit(:name, :address, :city, :state, :zip)
  # end
end
