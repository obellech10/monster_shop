require 'rails_helper'

RSpec.describe 'Merchant Items' do
  describe 'When I visit my items page' do
      before :each do
        @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)

        @user = User.create!(name: "Diane", address: "1331 Main St.", city: "Denver", state: "CO", zip: 80202, user_name: "diane@gmail.com", password: "test", role: 0)
        @merchant_admin = User.create!(name: "Jack", address: "1331 Main St.", city: "Denver", state: "CO", zip: 80202, user_name: "jack@gmail.com", password: "test", role: 2, merchant_id: @megan.id)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_admin)

        @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
        @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
        @hippo = @megan.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )

        @order_1 = Order.create!(user: @user, status: "pending")
        @order_items_1 = @order_1.order_items.create!(item: @ogre, price: @ogre.price, quantity: 1)
        @order_items_2 = @order_1.order_items.create!(item: @giant, price: @giant.price, quantity: 1)
      end

      it 'I see a button or link to delete an item that has never been ordered' do
        visit dashboard_items_path

        within "#item-#{@ogre.id}" do
          expect(page).to_not have_button("Delete Item")
        end

        within "#item-#{@giant.id}" do
          expect(page).to_not have_button("Delete Item")
        end

        within "#item-#{@hippo.id}" do
          expect(page).to have_button("Delete Item")

          click_button "Delete Item"
        end

        expect(current_path).to eq(dashboard_items_path)
        expect(page).to have_content("#{@hippo.name} has been deleted")

        expect(page).to_not have_css("#item-#{@hippo.id}")
      end
    end
  end
