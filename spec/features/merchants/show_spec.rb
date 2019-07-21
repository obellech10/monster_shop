require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe 'Merchant Show Page' do
  describe 'As a visitor' do
    before :each do
      @megan = User.create!(name: 'MegansMarmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, user_name: "iamgmail.com", password: "test", role: 2)
      @brian = User.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218, user_name: "ian@gmail.com", password: "test", role: 2)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20.25, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )

      @user = User.create!(name: "Diane", address: "1331 Main St.", city: "Denver", state: "CO", zip: 80202, user_name: "tom@gmail.com", password: "test", role: 0)
      @user_2 = User.create!(name: "Sam", address: "1331 Main St.", city: "Denver", state: "IA", zip: 80202, user_name: "sam@gmail.com", password: "test", role: 0)

      @order_1 = @user.orders.create!(status: 0)
      @order_2 = @user_2.orders.create!(status: 0)
      @order_2 = @user_2.orders.create!(status: 0)
      @order_1.order_items.create!(item: @ogre, price: @ogre.price, quantity: 2)
      @order_2.order_items.create!(item: @giant, price: @hippo.price, quantity: 2)
      @order_2.order_items.create!(item: @ogre, price: @hippo.price, quantity: 2)
    end

    it 'I see merchant name and address' do
      visit "/merchants/#{@megan.id}"

      expect(page).to have_content(@megan.name)

      within '.address' do
        expect(page).to have_content(@megan.address)
        expect(page).to have_content("#{@megan.city} #{@megan.state} #{@megan.zip}")
      end
    end

    it 'I see a link to this merchants items' do
      visit "/merchants/#{@megan.id}"

      click_link "Items"

      expect(current_path).to eq("/items")
    end

    it 'I see merchant statistics' do
      visit "/merchants/#{@megan.id}"

      within '.statistics' do
        expect(page).to have_content("Item Count: #{@megan.item_count}")
        expect(page).to have_content("Average Item Price: #{number_to_currency(@megan.average_item_price)}")
        expect(page).to have_content("Cities Served:\nDenver, CO\nDenver, IA")
      end
    end

    it 'I see stats for merchants with items, but no orders' do
      visit "/merchants/#{@brian.id}"

      within '.statistics' do
        expect(page).to have_content("Item Count: #{@brian.item_count}")
        expect(page).to have_content("Average Item Price: #{number_to_currency(@brian.average_item_price)}")
        expect(page).to have_content("This Merchant has no Orders!")
      end
    end
  end
end
