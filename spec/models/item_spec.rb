require 'rails_helper'

RSpec.describe Item do
  describe 'Relationships' do
    it {should belong_to :merchant}
    it {should have_many :order_items}
    it {should have_many(:orders).through(:order_items)}
    it {should have_many :reviews}
  end

  describe 'Validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
    it {should validate_presence_of :image}
    it {should validate_presence_of :price}
    it {should validate_presence_of :inventory}
  end

  describe 'Instance Methods' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)

      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )

      @review_1 = @ogre.reviews.create(title: 'Great!', description: 'This Ogre is Great!', rating: 5)
      @review_2 = @ogre.reviews.create(title: 'Meh.', description: 'This Ogre is Mediocre', rating: 3)
      @review_3 = @ogre.reviews.create(title: 'EW', description: 'This Ogre is Ew', rating: 1)
      @review_4 = @ogre.reviews.create(title: 'So So', description: 'This Ogre is So so', rating: 2)
      @review_5 = @ogre.reviews.create(title: 'Okay', description: 'This Ogre is Okay', rating: 4)

      @lamp = @megan.items.create!(name: 'Lamp', description: "I'm a Lamp!", price: 200, image: 'https://images.pexels.com/photos/39363/gift-made-package-loop-39363.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500', active: true, inventory: 10 )
      @plant = @brian.items.create!(name: 'Plant', description: "I'm a Plant!", price: 100, image: 'https://images.pexels.com/photos/39363/gift-made-package-loop-39363.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500', active: true, inventory: 10 )
      @chair = @megan.items.create!(name: 'chair', description: "I'm a chair!", price: 20, image: 'https://images.pexels.com/photos/39363/gift-made-package-loop-39363.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500', active: true, inventory: 10 )
      @table = @brian.items.create!(name: 'table', description: "I'm a table!", price: 10, image: 'https://images.pexels.com/photos/39363/gift-made-package-loop-39363.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500', active: true, inventory: 10 )
      @blanket = @megan.items.create!(name: 'blanket', description: "I'm a blanket!", price: 2, image: 'https://images.pexels.com/photos/39363/gift-made-package-loop-39363.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500', active: true, inventory: 10 )
      @dog = @brian.items.create!(name: 'dog', description: "I'm a dog!", price: 14, image: 'https://images.pexels.com/photos/39363/gift-made-package-loop-39363.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500', active: true, inventory: 10 )
      @cat = @brian.items.create!(name: 'cat', description: "I'm a cat!", price: 15, image: 'https://images.pexels.com/photos/39363/gift-made-package-loop-39363.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500', active: true, inventory: 10 )
      @bird = @brian.items.create!(name: 'bird', description: "I'm a bird!", price: 60, image: 'https://images.pexels.com/photos/39363/gift-made-package-loop-39363.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500', active: true, inventory: 10 )
      @elephant = @megan.items.create!(name: 'elephant', description: "I'm a elephant!", price: 40, image: 'https://images.pexels.com/photos/39363/gift-made-package-loop-39363.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500', active: true, inventory: 10 )
      @salmon = @megan.items.create!(name: 'salmon', description: "I'm a salmon!", price: 35, image: 'https://images.pexels.com/photos/39363/gift-made-package-loop-39363.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500', active: true, inventory: 10 )

      @order_1 = Order.create!(name: 'Megan A', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @order_2 = Order.create!(name: 'Julie S', address: '123 Tree St', city: 'Atlanta', state: 'GA', zip: 12345)
      @order_3 = Order.create!(name: 'Tay D', address: '123 Elk St', city: 'Miami', state: 'FL', zip: 83338)
      @order_4 = Order.create!(name: 'Molly L', address: '123 River St', city: 'Charlotte', state: 'NC', zip: 45618)
      @order_5 = Order.create!(name: 'Joe W', address: '123 Sea St', city: 'Boston', state: 'MA', zip: 45678)

      @order_item_1 = @order_1.order_items.create!(item: @lamp, price: @lamp.price, quantity: 9)
      @order_item_2 = @order_1.order_items.create!(item: @plant, price: @plant.price, quantity: 9)
      @order_item_3 = @order_2.order_items.create!(item: @chair, price: @chair.price, quantity: 8)
      @order_item_4 = @order_2.order_items.create!(item: @table, price: @table.price, quantity: 7)
      @order_item_5 = @order_3.order_items.create!(item: @blanket, price: @blanket.price, quantity: 6)
      @order_item_6 = @order_3.order_items.create!(item: @dog, price: @dog.price, quantity: 5)
      @order_item_7 = @order_4.order_items.create!(item: @cat, price: @cat.price, quantity: 4)
      @order_item_8 = @order_4.order_items.create!(item: @bird, price: @bird.price, quantity: 3)
      @order_item_9 = @order_5.order_items.create!(item: @elephant, price: @elephant.price, quantity: 2)
      @order_item_10 = @order_5.order_items.create!(item: @salmon, price: @salmon.price, quantity: 1)
    end

    describe "instance methods" do
      it '.sorted_reviews()' do
        expect(@ogre.sorted_reviews(3, :desc)).to eq([@review_1, @review_5, @review_2])
        expect(@ogre.sorted_reviews(3, :asc)).to eq([@review_3, @review_4, @review_2])
        expect(@ogre.sorted_reviews).to eq([@review_3, @review_4, @review_2, @review_5, @review_1])
      end

      it '.average_rating' do
        expect(@ogre.average_rating.round(2)).to eq(3.00)
      end
    end

    describe "class methods" do
      it '.top_five' do
        expect(Item.top_five).to eq([[@lamp.name, @order_item_1.quantity],
                                    [@plant.name, @order_item_2.quantity],
                                    [@chair.name, @order_item_3.quantity],
                                    [@table.name, @order_item_4.quantity],
                                    [@blanket.name, @order_item_5.quantity]])
      end

      it '.bottom_five' do
        expect(Item.bottom_five).to eq([[@salmon.name, @order_item_10.quantity],
                                       [@elephant.name, @order_item_9.quantity],
                                       [@bird.name, @order_item_8.quantity],
                                       [@cat.name, @order_item_7.quantity],
                                       [@dog.name, @order_item_6.quantity]])
      end
    end
  end
end
