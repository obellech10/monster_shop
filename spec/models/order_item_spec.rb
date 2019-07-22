require 'rails_helper'

RSpec.describe OrderItem do
  describe 'relationships' do
    it {should belong_to :order}
    it {should belong_to :item}
  end

  describe 'validations' do
    it {should validate_presence_of :price}
    it {should validate_presence_of :quantity}
  end

  describe 'instance methods' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)

      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20.25, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 7 )

      @user = User.create!(name: "Diane", address: "1331 Main St.", city: "Denver", state: "CO", zip: 80202, user_name: "tom@gmail.com", password: "test", role: 0)

      @order_1 = @user.orders.create!(status: "pending")
      @order_item_1 = @order_1.order_items.create!(item: @ogre, price: @ogre.price, quantity: 2, fulfilled: false)
      @order_item_2 = @order_1.order_items.create!(item: @hippo, price: @hippo.price, quantity: 3, fulfilled: false)

      @order_2 = @user.orders.create!(status: "pending")
      @order_item_3 = @order_2.order_items.create!(item: @giant, price: @giant.price, quantity: 4, fulfilled: false)
    end

    it '.subtotal' do
      expect(@order_item_1.subtotal).to eq(40.5)
      expect(@order_item_2.subtotal).to eq(150)
      expect(@order_item_3.subtotal).to eq(200)
    end

    describe ".cancel and .fulfill" do
      it "Any item quantities in the order are returned to their respective merchant's inventory for that item, and each row in OrderItems is given a status of 'unfulfilled'" do
        expect(@ogre.inventory).to eq(5)

        expect(@hippo.inventory).to eq(7)
        @order_item_2.fulfill
        expect(@hippo.inventory).to eq(4)

        expect(@giant.inventory).to eq(3)
        @order_item_3.fulfill
        expect(@giant.inventory).to eq(3)
        expect(@order_item_3.fulfilled?).to eq(false)

        @order_item_1.cancel

        expect(@order_item_1.reload.fulfilled?).to eq(false)
        expect(@ogre.reload.inventory).to eq(5)

        @order_item_2.cancel

        expect(@order_item_2.reload.fulfilled?).to eq(false)
        expect(@hippo.reload.inventory).to eq(7)

        @order_item_3.cancel

        expect(@order_item_3.reload.fulfilled?).to eq(false)
        expect(@giant.reload.inventory).to eq(3)
      end
    end
  end
end
