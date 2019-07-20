require "rails_helper"

RSpec.describe "User profile displays orders", type: :feature do
  before :each do
    @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
    @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
    @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
    @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
    @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
  end

  describe "As a registered user when I visit my Profile Orders page, /profile/orders" do
    it "I see every order I've made, which includes the following information:" do
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

      expect(page).to have_content("Order Created:")
      expect(page).to have_content("Order Status:")
      expect(page).to have_content("Order Last Updated:")
      expect(page).to have_content("Order Quantity:")
      expect(page).to have_content("Grand Total:")
    end
  end
end
