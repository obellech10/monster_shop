require "rails_helper"

RSpec.describe "Admin Can See A Merchant's Dashboard", type: :feature do
  describe 'As an admin user' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @user_1 = User.create!(name: "Diane", address: "1331 Main St.", city: "Denver", state: "CO", zip: 80202, user_name: "diane@gmail.com", password: "test", role: 0)
      @user_2 = User.create!(name: "Sam", address: "1331 Main St.", city: "Denver", state: "IA", zip: 80202, user_name: "sam@gmail.com", password: "test", role: 2, merchant_id: @megan.id)

      @admin = User.create!(name: "Jack", address: "1331 Main St.", city: "Denver", state: "CO", zip: 80202, user_name: "jack@gmail.com", password: "test", role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20.25, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )

      @order_1 = Order.create!(user: @user_1, status: "pending")

      @order_items_1 = @order_1.order_items.create!(item: @ogre, price: @ogre.price, quantity: 2)
      @order_items_2 = @order_1.order_items.create!(item: @giant, price: @ogre.price, quantity: 3)
    end

    describe 'When I visit the merchant index page ("/merchants")' do
      it 'I click on a merchants name, my URI route should be ("/admin/merchants/6"), I see everything that merchant would see' do
        visit admin_merchants_path

        expect(page).to have_link(@megan.name)
        click_link "#{@megan.name}"
        expect(current_path).to eq(admin_merchant_path(@megan))

        expect(page).to have_content(@megan.address)
        expect(page).to have_content(@megan.city)
        expect(page).to have_content(@megan.state)
        expect(page).to have_content(@megan.zip)
      end
    end
  end
end
