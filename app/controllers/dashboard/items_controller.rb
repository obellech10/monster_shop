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

  def new
    @item = Item.new
  end

  def create
    @merchant = Merchant.find(current_user.merchant_id)
    @item = @merchant.items.new(item_params)
    if @item.save
      flash[:success] = "#{@item.name} has been created"
      redirect_to dashboard_items_path
    else
      flash[:error] = @item.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  def item_params
    item = params.require(:item).permit(:name, :description, :price, :image, :inventory)
    if item[:image].empty?
      item[:image] = "https://www.google.com/imgres?imgurl=http%3A%2F%2Fwww.stleos.uq.edu.au%2Fwp-content%2Fuploads%2F2016%2F08%2Fimage-placeholder-350x350.png&imgrefurl=http%3A%2F%2Fwww.stleos.uq.edu.au%2Flive-on-campus%2Faccommodation%2Fimage-placeholder%2F&docid=YPZY41tiqQXLcM&tbnid=8RNNVPLyHn5RyM%3A&vet=10ahUKEwiDt_GStszjAhVIU80KHS3HDHkQMwiKASgJMAk..i&w=350&h=350&bih=766&biw=1440&q=placeholder%20image&ved=0ahUKEwiDt_GStszjAhVIU80KHS3HDHkQMwiKASgJMAk&iact=mrc&uact=8"
    end
    item
  end
end
