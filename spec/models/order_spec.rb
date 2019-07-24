require 'rails_helper'

RSpec.describe Order do
  describe 'relationships' do
    it {should have_many :order_items}
    it {should have_many(:items).through(:order_items)}
    it {should belong_to :user}
  end

  describe 'validations' do
    it {should validate_presence_of :status}
  end

  describe 'instance methods' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)

      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20.25, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )

      @user = User.create!(name: "Sam", address: "1331 17th St.", city: "Denver", state: "CO", zip: 80202, user_name: "iam@gmail.com", password: "test", role: 0)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      @order_1 = Order.create!(user: @user)
      @order_2 = Order.create!(user: @user)

      @order_1.order_items.create!(item: @ogre, price: @ogre.price, quantity: 2)
      @order_1.order_items.create!(item: @hippo, price: @hippo.price, quantity: 3)
      @order_2.order_items.create!(item: @hippo, price: @hippo.price, quantity: 2)
    end

    it '.grand_total' do
      expect(@order_1.grand_total).to eq(190.5)
      expect(@order_2.grand_total).to eq(100)
    end

    it '.total_quantity' do
      expect(@order_1.total_quantity).to eq(5)
      expect(@order_2.total_quantity).to eq(2)
    end

    it ".merchant_items" do
      expect(@order_1.merchant_items(@megan).first).to eq(@ogre)
      expect(@order_2.merchant_items(@brian).first).to eq(@hippo)
    end

    it ".total_value" do
      expect(@order_1.total_value(@megan)).to eq(40.5)
    end

    it ".total_merchant_items" do
      expect(@order_1.total_merchant_items(@megan)).to eq(2)
      expect(@order_1.total_merchant_items(@brian)).to eq(3)
    end

    it ".user_address" do
      expect(@order_1.user_address(@order_1)).to eq("1331 17th St. Denver CO 80202")
    end
  end

  describe 'Class Methods' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)

      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20.25, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )

      @user = User.create!(name: "Sam", address: "1331 17th St.", city: "Denver", state: "CO", zip: 80202, user_name: "iam@gmail.com", password: "test", role: 0)

      @order_1 = Order.create!(user: @user, status: 'pending')
      @order_1.order_items.create!(item: @ogre, price: @ogre.price, quantity: 2)
      @order_1.order_items.create!(item: @hippo, price: @hippo.price, quantity: 3)

      @order_2 = Order.create!(user: @user, status: 'cancelled')
      @order_2.order_items.create!(item: @hippo, price: @hippo.price, quantity: 2)

      @order_3 = Order.create!(user: @user, status: 'packaged')
      @order_3.order_items.create!(item: @hippo, price: @hippo.price, quantity: 2)

      @order_4 = Order.create!(user: @user, status: 'shipped')
      @order_4.order_items.create!(item: @hippo, price: @hippo.price, quantity: 2)
    end

    it '.sorted_orders' do
      sorted = [@order_3, @order_1, @order_4, @order_2]
      expect(Order.sorted_orders).to eq(sorted)
    end
  end
end
