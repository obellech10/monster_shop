require 'rails_helper'
include ActionView::Helpers::NumberHelper
RSpec.describe 'Merchant Dashboard Order Show Page' do
  describe 'As a merchant, when I visit an order show page from my dashboard' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)

      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20.25, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 8 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )

      @user = User.create!(name: "Diane", address: "1331 Main St.", city: "Denver", state: "CO", zip: 80202, user_name: "tom@gmail.com", password: "test", role: 2, merchant_id: @megan.id)
      @user_2 = User.create!(name: "Sam", address: "1331 Main St.", city: "Denver", state: "IA", zip: 80202, user_name: "sam@gmail.com", password: "test", role: 0)

      @order_1 = @user_2.orders.create!(status: 0)
      @order_2 = @user_2.orders.create!(status: 0)

      @order_1.order_items.create!(item: @ogre, price: @ogre.price, quantity: 2, fulfilled: false)
      @order_2.order_items.create!(item: @giant, price: @giant.price, quantity: 1, fulfilled: false)
      @order_2.order_items.create!(item: @ogre, price: @ogre.price, quantity: 3, fulfilled: false)
    end

    it "all items in an order have been fulfilled by their merchants, the order status changes from pending to packaged" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit profile_path
      click_link "Dashboard"
      click_link "#{@order_1.id}"
      click_button "Fulfill"

      
# When all items in an order have been "fulfilled" by their merchants
# The order status changes from "pending" to "packaged"


    end
  end
end
