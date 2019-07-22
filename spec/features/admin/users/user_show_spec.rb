require "rails_helper"

RSpec.describe "Admin User Profile Page", type: :feature do
  describe 'As an admin user' do
    before :each do
      @user_1 = User.create!(name: "Diane", address: "1331 Main St.", city: "Denver", state: "CO", zip: 80202, user_name: "diane@gmail.com", password: "test", role: 0)
      @user_2 = User.create!(name: "Sam", address: "1331 Main St.", city: "Denver", state: "IA", zip: 80202, user_name: "sam@gmail.com", password: "test", role: 0)

      @admin = User.create!(name: "Jack", address: "1331 Main St.", city: "Denver", state: "CO", zip: 80202, user_name: "jack@gmail.com", password: "test", role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)

      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20.25, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )

      @order_1 = Order.create!(user: @user_1, status: "pending")

      @order_items_1 = @order_1.order_items.create!(item: @ogre, price: @ogre.price, quantity: 2)
      @order_items_2 = @order_1.order_items.create!(item: @giant, price: @ogre.price, quantity: 3)
    end

    describe 'I visit a users profile page' do
      it 'I see all the information they would see, but dont see a link to edit' do
        visit admin_user_path(@user_1.id)

        expect(page).to have_content("#{@user_1.name}'s Profile")
        expect(page).to have_content(@user_1.address)
        expect(page).to have_content(@user_1.city)
        expect(page).to have_content(@user_1.state)
        expect(page).to have_content(@user_1.zip)
        expect(page).to have_content(@user_1.user_name)
        expect(page).to_not have_link("Edit Profile")

        within "#order-#{@order_1.id}" do
          expect(page).to have_content("Order ID: #{@order_1.id}")
          expect(page).to have_content("Order Created: #{@order_1.created_at}")
          expect(page).to have_content("Order Last Updated: #{@order_1.updated_at}")
          expect(page).to have_content("Order Status: #{@order_1.status}")
          expect(page).to have_content(@order_1.total_quantity)
          expect(page).to have_content(@order_1.grand_total)
        end
      end
    end
  end
end
