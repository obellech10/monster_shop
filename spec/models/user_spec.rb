require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
    it { should validate_presence_of :password }
    it { should validate_uniqueness_of :user_name }
  end

  describe "relationships" do
    it { should have_many :orders }
    it {should have_many :items}
    it {should have_many(:order_items).through(:items)}
  end

  describe 'Instance Methods' do
    before :each do
      @megan = User.create!(name: "Megan", address: "1331 Main St.", city: "Denver", state: "CO", zip: 80202, user_name: "tom@gmail.com", password: "test", role: 2)
      @brian = User.create!(name: "Brian", address: "1331 Tree St.", city: "Denver", state: "IA", zip: 80202, user_name: "sam@gmail.com", password: "test", role: 2)

      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20.25, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )

      @user_1 = User.create!(name: "Joe", address: "1331 Red St.", city: "Denver", state: "CO", zip: 82332, user_name: "iam@gmail.com", password: "test", role: 0)
      @user_2 = User.create!(name: "Sally", address: "1331 Blue St.", city: "Denver", state: "IA", zip: 83402, user_name: "lamp@gmail.com", password: "test", role: 0)

      @order_1 = @user_1.orders.create!(status: 0)
      @order_2 = @user_2.orders.create!(status: 0)

      @order_1.order_items.create!(item: @ogre, price: @ogre.price, quantity: 2)
      @order_1.order_items.create!(item: @hippo, price: @hippo.price, quantity: 3)
      @order_2.order_items.create!(item: @giant, price: @hippo.price, quantity: 2)
      @order_2.order_items.create!(item: @ogre, price: @hippo.price, quantity: 2)
    end

    it '.item_count' do
      expect(@megan.item_count).to eq(2)
      expect(@brian.item_count).to eq(1)
    end

    it '.average_item_price' do
      expect(@megan.average_item_price.round(2)).to eq(35.13)
      expect(@brian.average_item_price.round(2)).to eq(50.00)
    end

    it '.distinct_cities' do
      expect(@megan.distinct_cities).to eq(['Denver, CO', 'Denver, IA'])
    end
  end
end
