require "rails_helper"

RSpec.describe "Admin Dashboard", type: :feature do
  describe 'As an admin user' do
    before :each do
      @user_1 = User.create!(name: "Diane", address: "1331 Main St.", city: "Denver", state: "CO", zip: 80202, user_name: "diane@gmail.com", password: "test", role: 0)
      @user_2 = User.create!(name: "Sam", address: "1331 Main St.", city: "Denver", state: "IA", zip: 80202, user_name: "sam@gmail.com", password: "test", role: 0)

      @admin = User.create!(name: "Jack", address: "1331 Main St.", city: "Denver", state: "CO", zip: 80202, user_name: "jack@gmail.com", password: "test", role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)

      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20.25, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 7 )

      @order_1 = Order.create!(user: @user_1, status: "pending")
      @order_items_1 = @order_1.order_items.create!(item: @ogre, price: @ogre.price, quantity: 1)
      @order_items_2 = @order_1.order_items.create!(item: @giant, price: @giant.price, quantity: 3)

      @order_2 = Order.create!(user: @user_2, status: "packaged")
      @order_items_3 = @order_2.order_items.create!(item: @ogre, price: @ogre.price, quantity: 2)
      @order_items_4 = @order_2.order_items.create!(item: @giant, price: @giant.price, quantity: 1)
      @order_items_5 = @order_2.order_items.create!(item: @hippo, price: @hippo.price, quantity: 1)

      @order_3 = Order.create!(user: @user_1, status: "shipped")
      @order_items_6 = @order_3.order_items.create!(item: @ogre, price: @ogre.price, quantity: 1)
      @order_items_7 = @order_3.order_items.create!(item: @giant, price: @giant.price, quantity: 1)
      @order_items_8 = @order_3.order_items.create!(item: @hippo, price: @hippo.price, quantity: 1)

      @order_4 = Order.create!(user: @user_2, status: "cancelled")
      @order_items_9 = @order_4.order_items.create!(item: @ogre, price: @ogre.price, quantity: 2)
      @order_items_10 = @order_4.order_items.create!(item: @giant, price: @giant.price, quantity: 2)
    end

    it 'I see all orders in the system' do
      visit '/admin/dashboard'
      expect(current_path).to eq(admin_dashboard_path)

      sorted = [@order_2, @order_1, @order_3, @order_4]
      expect(Order.sorted_orders).to eq(sorted)

      within "#order-#{@order_2.id}" do
        expect(page).to have_content("User Id: #{@order_2.user_id}")
        expect(page).to have_link("User Id: #{@order_2.user_id}")
        expect(page).to have_content("Order Id: #{@order_2.id}")
        expect(page).to have_content("Order Created: #{@order_2.created_at}")
      end

      within "#order-#{@order_1.id}" do
        expect(page).to have_content("User Id: #{@order_1.user_id}")
        expect(page).to have_link("User Id: #{@order_1.user_id}")
        expect(page).to have_content("Order Id: #{@order_1.id}")
        expect(page).to have_content("Order Created: #{@order_1.created_at}")
      end

      within "#order-#{@order_3.id}" do
        expect(page).to have_content("User Id: #{@order_3.user_id}")
        expect(page).to have_link("User Id: #{@order_3.user_id}")
        expect(page).to have_content("Order Id: #{@order_3.id}")
        expect(page).to have_content("Order Created: #{@order_3.created_at}")
      end

      within "#order-#{@order_4.id}" do
        expect(page).to have_content("User Id: #{@order_4.user_id}")
        expect(page).to have_link("User Id: #{@order_4.user_id}")
        expect(page).to have_content("Order Id: #{@order_4.id}")
        expect(page).to have_content("Order Created: #{@order_4.created_at}")
      end
    end
  end
end
