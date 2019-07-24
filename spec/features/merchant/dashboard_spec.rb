require 'rails_helper'

RSpec.describe 'Merchant Dashboard Show Page', type: :feature do
  describe 'As a Merchant' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)

      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20.25, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 8 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )

      @user = User.create!(name: "Diane", address: "1331 Main St.", city: "Denver", state: "CO", zip: 80202, user_name: "tom@gmail.com", password: "test", role: "merchant_admin", merchant_id: @megan.id)
      @user_2 = User.create!(name: "Sam", address: "1331 Main St.", city: "Denver", state: "IA", zip: 80202, user_name: "sam@gmail.com", password: "test", role: 0)

      @order_1 = @user_2.orders.create!(status: "pending")

      @order_1.order_items.create!(item: @ogre, price: @ogre.price, quantity: 2, fulfilled: false)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'When I visit my merchant dashboard, I see my profile data but cannot edit it' do
      visit merchant_dashboard_path

      expect(page).to have_content(@megan.name)
      expect(page).to have_content(@megan.address)
      expect(page).to have_content(@megan.city)
      expect(page).to have_content(@megan.state)
      expect(page).to have_content(@megan.zip)

      expect(page).to_not have_button('Edit')
    end

    it "If any users have pending orders containing items I sell, then I see a list of these orders, and the following" do
      visit merchant_dashboard_path

      expect(page).to have_content("Order Number: #{@order_1.id}")
      expect(page).to have_content(@order_1.created_at)
      expect(@order_1.total_merchant_items(@megan)).to eq(2)
      expect(page).to have_content("Total Quantity: 2")
      expect(@order_1.total_value(@megan)).to eq(40.5)
      expect(page).to have_content("Total Value: $40.50")

      expect(page).to have_link("#{@order_1.id}")
      click_link "#{@order_1.id}"
      expect(current_path).to eq(merchant_order_show_path(@order_1.id))
    end
  end
end
