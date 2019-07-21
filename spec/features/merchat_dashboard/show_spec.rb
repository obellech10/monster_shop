require "rails_helper"

RSpec.describe "Merchant Dashboard Show Page", type: :feature do
  describe 'As a merchant' do
    before :each do
      @merchant = User.create!(name: "Sam", address: "1331 17th St.", city: "Denver", state: "CO", zip: 80202, user_name: "iam@gmail.com", password: "test", role: 2)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)
    end

    it 'I see all my profile details on the page and cannot edit them' do
      visit merchant_dashboard_path

      expect(current_path).to eq(merchant_dashboard_path)
      expect(page).to have_content("#{@merchant.name}'s Profile")
      expect(page).to have_content(@merchant.address)
      expect(page).to have_content(@merchant.city)
      expect(page).to have_content(@merchant.state)
      expect(page).to have_content(@merchant.zip)
      expect(page).to have_content(@merchant.user_name)
    end

    it "As a regular user i cannot visit the merchant dashboard path" do
      @user = User.create!(name: "Lisa", address: "1331 25th Ave.", city: "Miami", state: "FL", zip: 80242, user_name: "bird@gmail.com", password: "fish", role: 0)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit merchant_dashboard_path
      expect(page).to have_content("The page you were looking for doesn't exist (404)")
    end

    it "If any users have pending orders containing items I sell then I see a
    list of these orders each order listed includes the following information:" do
    @user = User.create!(name: "Lisa", address: "1331 25th Ave.", city: "Miami", state: "FL", zip: 80242, user_name: "bird@gmail.com", password: "fish", role: 0)

    @ogre = @merchant.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20.25, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
    @giant = @merchant.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )

    @order_1 = Order.create!(user: @user, status: "pending")
    @order_2 = Order.create!(user: @user)

    @order_items_1 = @order_1.order_items.create!(item: @ogre, price: @ogre.price, quantity: 2)
    @order_items_2 = @order_1.order_items.create!(item: @giant, price: @ogre.price, quantity: 3)
    visit merchant_dashboard_path

    expect(page).to have_content(@order_1.id)
    expect(page).to have_link("Order #{@order_1.id}")
    expect(page).to have_content(@order_1.created_at)
    expect(page).to have_content(@order_1.total_quantity_merchant)
    expect(page).to have_content(@order_1.grand_total_merchant)

    end
  end
end

# - the ID of the order, which is a link to the order show page ("/merchant/orders/15")
# - the date the order was made
# - the total quantity of my items in the order
# - the total value of my items for that order
