require 'rails_helper'
include ActionView::Helpers::NumberHelper
RSpec.describe 'Admin can ship an order' do
  describe 'As an admin user, when I log into my dashboard, /admin/dashboard' do
    before :each do
      @user_1 = User.create!(name: "Diane", address: "1331 Main St.", city: "Denver", state: "CO", zip: 80202, user_name: "diane@gmail.com", password: "test", role: 0)
      @user_2 = User.create!(name: "Sam", address: "1331 Main St.", city: "Denver", state: "IA", zip: 80202, user_name: "sam@gmail.com", password: "test", role: 0)

      @admin = User.create!(name: "Jack", address: "1331 Main St.", city: "Denver", state: "CO", zip: 80202, user_name: "jack@gmail.com", password: "test", role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)

      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20.25, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 50 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 32 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 17 )

      @order_1 = Order.create!(user: @user_1, status: 0)
      @order_items_1 = @order_1.order_items.create!(item: @ogre, price: @ogre.price, quantity: 1)
      @order_items_2 = @order_1.order_items.create!(item: @giant, price: @giant.price, quantity: 3)

      @order_2 = Order.create!(user: @user_2, status: 1)
      @order_items_3 = @order_2.order_items.create!(item: @ogre, price: @ogre.price, quantity: 2)
      @order_items_4 = @order_2.order_items.create!(item: @giant, price: @giant.price, quantity: 1)
      @order_items_5 = @order_2.order_items.create!(item: @hippo, price: @hippo.price, quantity: 1)

      @order_3 = Order.create!(user: @user_1, status: 0)
      @order_items_6 = @order_3.order_items.create!(item: @ogre, price: @ogre.price, quantity: 1)
      @order_items_7 = @order_3.order_items.create!(item: @giant, price: @giant.price, quantity: 1)
      @order_items_8 = @order_3.order_items.create!(item: @hippo, price: @hippo.price, quantity: 1)

      @order_4 = Order.create!(user: @user_2, status: 0)
      @order_items_9 = @order_4.order_items.create!(item: @ogre, price: @ogre.price, quantity: 2)
      @order_items_10 = @order_4.order_items.create!(item: @giant, price: @giant.price, quantity: 2)
    end

    it "Then I see any packaged orders ready to ship." do
      visit admin_dashboard_path
      expect(page).to have_content(@order_2.id)
      expect(page).to have_content('Admin Dashboard')
      expect(page).to_not have_content(@order_1.id)
      expect(page).to_not have_content(@order_3.id)
      expect(page).to_not have_content(@order_4.id)
    end

    it "Next to each order I see a button to ship the order." do
      visit admin_dashboard_path
      expect(page).to have_content(@order_2.id)
      expect(page).to have_button('Ship Order')
    end

    it "When I click that button for an order, the status of that order changes to shipped, and the user can no longer cancel the order." do
      @order_1.update(status: 1)
      visit admin_dashboard_path
      @order_1.shipped!
      expect(@order_1.status).to eq('shipped')
    end
  end
end
