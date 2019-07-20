require "rails_helper"
include ActionView::Helpers::NumberHelper

RSpec.describe "Users can view order show page", type: :feature do
  before :each do
    @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)

    @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20.25, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
    @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )

    @user = User.create!(name: "Sam", address: "1331 17th St.", city: "Denver", state: "CO", zip: 80202, user_name: "iam@gmail.com", password: "test", role: 0)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    @order_1 = Order.create!(user: @user, status: "pending")
    # @order_2 = Order.create!(user: @user)

    @order_items_1 = @order_1.order_items.create!(item: @ogre, price: @ogre.price, quantity: 2)
    @order_items_2 = @order_1.order_items.create!(item: @giant, price: @ogre.price, quantity: 3)
  end

  describe "As a registered user, when I visit my Profile Orders page, and I click on a link for order's show page" do
    it "My URL route is now something like /profile/orders/15, and I see all information about the order, including the following information:" do
      visit profile_orders_path

      click_link "Order #{@order_1.id}"
      expect(current_path).to eq(order_show_path(@order_1))

      expect(page).to have_content("Order ID: #{@order_1.id}")
      expect(page).to have_content("Order Created: #{@order_1.created_at}")
      expect(page).to have_content("Order Last Updated: #{@order_1.updated_at}")
      expect(page).to have_content("Order Status: #{@order_1.status}")
      expect(page).to have_content(@order_1.total_quantity)
      expect(page).to have_content(@order_1.grand_total)
      expect(page).to have_content("Cart: 0")

      within "#item-#{@ogre.id}" do
        expect(page).to have_content(@order_items_1.item.name)
        expect(page).to have_content(@ogre.description)
        expect(page).to have_content(@order_items_1.quantity)
        expect(page).to have_content(@order_items_1.price)
        expect(page).to have_css("img[src*='#{@ogre.image}']")
        expect(page).to have_content("Subtotal: #{number_to_currency(@order_items_1.subtotal)}")
      end

      within "#item-#{@giant.id}" do
        expect(page).to have_content(@order_items_2.item.name)
        expect(page).to have_content(@giant.description)
        expect(page).to have_content(@order_items_2.quantity)
        expect(page).to have_content(@order_items_2.price)
        expect(page).to have_css("img[src*='#{@giant.image}']")
        expect(page).to have_content("Subtotal: #{number_to_currency(@order_items_2.subtotal)}")
      end
    end
  end
end
