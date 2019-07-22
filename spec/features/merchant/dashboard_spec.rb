require 'rails_helper'

RSpec.describe 'Merchant Dashboard Show Page', type: :feature do
  describe 'As a Merchant' do
    before :each do
      @merchant = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)

      @merchant_admin = User.create!(name: "Sam", address: "1331 17th St.", city: "Denver", state: "CO", zip: 80202, user_name: "iam@gmail.com", password: "test", role: 2, merchant_id: @merchant.id)
      @user = User.create!(name: "Sam", address: "1331 17th St.", city: "Denver", state: "CO", zip: 80202, user_name: "sam@gmail.com", password: "test", role: 0, merchant_id: nil)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_admin)

      @ogre = @merchant.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20.25, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @merchant.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )

      @order_1 = Order.create!(user: @user, status: "pending")

      @order_items_1 = @order_1.order_items.create!(item: @ogre, price: @ogre.price, quantity: 2)
      @order_items_2 = @order_1.order_items.create!(item: @giant, price: @ogre.price, quantity: 3)
      @order_items_3 = @order_1.order_items.create!(item: @hippo, price: @hippo.price, quantity: 3)
    end

    it 'When I visit my merchant dashboard, I see my profile data but cannot edit it' do
      visit merchant_dashboard_path

      expect(page).to have_content(@merchant.name)
      expect(page).to have_content(@merchant.address)
      expect(page).to have_content(@merchant.city)
      expect(page).to have_content(@merchant.state)
      expect(page).to have_content(@merchant.zip)

      expect(page).to_not have_button('Edit')
    end

    it 'Displays list of pending orders with items I sell' do
      visit merchant_dashboard_path
save_and_open_page
      expect(page).to have_content(@merchant.name)
      expect(page).to_not have_content(@brian.name)

      within "#order-#{@order_1.id}" do
        expect(page).to have_content(@order_1.id)
        # expect(page).to have_link(@order_1.id)
        expect(page).to have_content(@order_1.created_at)
        expect(page).to have_content(@order_1.total_quantity)
        expect(page).to have_content(@order_1.grand_total)
      end
    end
  end
end
