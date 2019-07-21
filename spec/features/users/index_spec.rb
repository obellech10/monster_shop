require "rails_helper"

RSpec.describe "User profile displays orders", type: :feature do
  before(:each) do
    @megan = User.create!(name: 'MegansMarmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, user_name: "iamgmail.com", password: "test", role: 2)
    @brian = User.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218, user_name: "ian@gmail.com", password: "test", role: 2)

    @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20.25, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
    @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )

    @user = User.create!(name: "Sam", address: "1331 17th St.", city: "Denver", state: "CO", zip: 80202, user_name: "iam@gmail.com", password: "test", role: 0)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    @order_1 = Order.create!(user: @user)
    @order_2 = Order.create!(user: @user)

    @order_1.order_items.create!(item: @ogre, price: @ogre.price, quantity: 2)
    @order_2.order_items.create!(item: @giant, price: @giant.price, quantity: 5)
  end

  describe "As a registered user when I visit my Profile Orders page, /profile/orders" do
    it "I see every order I've made, which includes the following information:" do

      visit profile_path
      click_link "My Orders"
      expect(current_path).to eq(profile_orders_path)

      within ".order-#{@order_1.id}" do
        expect(page).to have_content("Order Created: #{@order_1.created_at}")
        expect(page).to have_content("Order Last Updated: #{@order_1.updated_at}")
        expect(page).to have_content("Order Status: #{@order_1.status}")
        expect(page).to have_content("Order Quantity: #{@order_1.total_quantity}")
        expect(page).to have_content("Grand Total: #{@order_1.grand_total}")
        expect(page).to have_content("Order #{@order_1.id}")
        expect(page).to have_link("Order #{@order_1.id}")
      end

      within ".order-#{@order_2.id}" do
        expect(page).to have_content("Order #{@order_2.id}")
        expect(page).to have_link("Order #{@order_2.id}")
        expect(page).to have_content("Order Created: #{@order_2.created_at}")
        expect(page).to have_content("Order Last Updated: #{@order_2.updated_at}")
        expect(page).to have_content("Order Status: #{@order_2.status}")
        expect(page).to have_content("Order Quantity: #{@order_2.total_quantity}")
        expect(page).to have_content("Grand Total: #{@order_2.grand_total}")
        expect(page).to have_link("Order #{@order_2.id}")
      end

      click_link "Order #{@order_1.id}"
      expect(current_path).to eq("/profile/orders/#{@order_1.id}")

      visit profile_orders_path

      click_link "Order #{@order_1.id}"
      expect(current_path).to eq("/profile/orders/#{@order_1.id}")
    end
  end
end
