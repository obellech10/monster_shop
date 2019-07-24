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

      @order_1 = @user_2.orders.create!(status: "pending")
      @order_2 = @user_2.orders.create!(status: "pending")

      @order_1.order_items.create!(item: @ogre, price: @ogre.price, quantity: 2, fulfilled: false)
      @order_2.order_items.create!(item: @giant, price: @giant.price, quantity: 1, fulfilled: false)
      @order_2.order_items.create!(item: @ogre, price: @ogre.price, quantity: 3, fulfilled: false)
    end

    it 'I see the customers name and address, as well as the items in that order that belong to me' do

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit profile_path
      click_link "Dashboard"

      expect(current_path).to eq(merchant_dashboard_path)

      expect(page).to have_content("Order Number:")
      click_link "#{@order_1.id}"

      expect(current_path).to eq(merchant_order_show_path(@order_1.id))

      expect(page).to have_content(@user_2.name)
      expect(page).to have_content(@user_2.address)
      expect(page).to have_content(@user_2.city)
      expect(page).to have_content(@user_2.state)
      expect(page).to have_content(@user_2.zip)

      expect(page).to have_content(@ogre.name)
      expect(page).to have_css("img[src*='#{@ogre.image}']")
      expect(page).to have_content(@ogre.price)
      expect(page).to_not have_content(@giant.name)

      expect(page).to have_link("Fulfill")
      expect(@order_1.order_items.first.fulfilled?).to eq(false)
      click_on "Fulfill"
      expect(current_path).to eq(merchant_order_show_path(@order_1.id))
      expect(@order_1.order_items.first.fulfilled?).to eq(true)
      expect(page).to_not have_link("Fulfill")
    end
  end
end
