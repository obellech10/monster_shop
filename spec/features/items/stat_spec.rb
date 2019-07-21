require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe 'Item Index Page' do
  before(:each) do
    @megan = User.create!(name: 'MegansMarmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, user_name: "iamgmail.com", password: "test", role: 2)
    @brian = User.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218, user_name: "ian@gmail.com", password: "test", role: 2)

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

    @user = User.create!(name: "Diane", address: "1331 Main St.", city: "Denver", state: "CO", zip: 80202, user_name: "tom@gmail.com", password: "test", role: 0)

    @order_1 = @user.orders.create!(status: 0)
    @order_2 = @user.orders.create!(status: 0)
    @order_3 = @user.orders.create!(status: 0)
    @order_4 = @user.orders.create!(status: 0)
    @order_5 = @user.orders.create!(status: 0)

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

  describe 'As any user' do
    it "I see an area with statistics" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit '/items'

      within '#popular' do
        expect(page.all('li')[0]).to have_content("Lamp")
        expect(page.all('li')[1]).to have_content("Plant")
        expect(page.all('li')[2]).to have_content("chair")
        expect(page.all('li')[3]).to have_content("table")
        expect(page.all('li')[4]).to have_content("blanket")
      end

      within '#least-popular' do
        expect(page.all('li')[0]).to have_content("salmon")
        expect(page.all('li')[1]).to have_content("elephant")
        expect(page.all('li')[2]).to have_content("bird")
        expect(page.all('li')[3]).to have_content("cat")
        expect(page.all('li')[4]).to have_content("dog")
      end
    end
  end
end
