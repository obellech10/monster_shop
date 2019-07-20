require "rails_helper"

RSpec.describe "Users can view order show page", type: :feature do
  before :each do
    @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
    @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
    @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
    @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
    @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
  end

  describe "As a registered user, when I visit my Profile Orders page, and I click on a link for order's show page" do
    it "My URL route is now something like /profile/orders/15, and I see all information about the order, including the following information:" do

      user = User.create!(name: "Diane", address: "1331 Main St.", city: "Denver", state: "CO", zip: 80202, user_name: "tom@gmail.com", password: "test", role: 0)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit item_path(@ogre)
      click_button 'Add to Cart'

      visit item_path(@hippo)
      click_button 'Add to Cart'

      visit cart_path
      click_button "Check Out"
      click_button "Create Order"


      visit profile_path
      click_link "My Orders"

      click_link "Order #{user.orders.first.id}"

      expect(page).to have_content("Status: pending")
      expect(page).to have_content("Your Order")
      expect(page).to have_content(@ogre.name)
      expect(page).to have_content(@hippo.name)
      expect(page).to have_content("Cart: 0")
    end
  end
end
