require "rails_helper"

RSpec.describe "User cancels an order" do
  describe "As a registered user" do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)

      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20.25, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )

      @user = User.create!(name: "Sam", address: "1331 17th St.", city: "Denver", state: "CO", zip: 80202, user_name: "iam@gmail.com", password: "test", role: 0)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      @order_pending_1 = Order.create!(user: @user, status: "pending")
      @order_items_1 = @order_pending_1.order_items.create!(item: @ogre, price: @ogre.price, quantity: 2, fulfilled: false)
      @order_items_2 = @order_pending_1.order_items.create!(item: @giant, price: @giant.price, quantity: 1, fulfilled: true)

      @order_pending_2 = Order.create!(user: @user, status: "pending")
      @order_items_3 = @order_pending_2.order_items.create!(item: @hippo, price: @hippo.price, quantity: 1)

      @order_packaged = Order.create!(user: @user, status: "packaged")
      @order_items_4 = @order_packaged.order_items.create!(item: @giant, price: @giant.price, quantity: 1)

      @order_shipped = Order.create!(user: @user, status: "shipped")
      @order_items_5 = @order_shipped.order_items.create!(item: @hippo, price: @hippo.price, quantity: 1)

      @order_cancelled = Order.create!(user: @user, status: "cancelled")
      @order_items_6 = @order_cancelled.order_items.create!(item: @hippo, price: @hippo.price, quantity: 1)
    end

    describe "When I visit an order's show page" do
      it "I see a button or link to cancel the order only if the order is still pending" do
        visit order_show_path(@order_pending_1)
        expect(page).to have_button("Cancel Order")

        visit order_show_path(@order_pending_2)
        expect(page).to have_button("Cancel Order")

        visit order_show_path(@order_packaged)
        expect(page).to_not have_button("Cancel Order")

        visit order_show_path(@order_shipped)
        expect(page).to_not have_button("Cancel Order")

        visit order_show_path(@order_cancelled)
        expect(page).to_not have_button("Cancel Order")
      end

      context "When I click the cancel button for an order" do
        it "Each row in OrderItems table has 'unfulfilled' status, and the order itself has a 'cancelled' status" do
          visit order_show_path(@order_pending_1)

          click_button("Cancel Order")

          expect(@order_items_1.reload.fulfilled?).to eq(false)
          expect(@order_items_2.reload.fulfilled?).to eq(false)
          expect(@order_pending_1.reload.status).to eq("cancelled")
        end

        it "I am returned to my profile page and see a flash message telling me the order is now cancelled" do
          visit order_show_path(@order_pending_1)

          click_button("Cancel Order")
          expect(current_path).to eq(profile_orders_path)
          expect(page).to have_content("Order #{@order_pending_1.id} has been cancelled.")

          within ".order-#{@order_pending_1.id}" do
            expect(page).to have_content("Order Status: cancelled")
          end

          visit order_show_path(@order_pending_2)

          click_button("Cancel Order")
          expect(current_path).to eq(profile_orders_path)
          expect(page).to have_content("Order #{@order_pending_2.id} has been cancelled.")

          within ".order-#{@order_pending_2.id}" do
            expect(@order_pending_2.reload.status).to eq("cancelled")
          end
        end
      end
    end
  end
end
