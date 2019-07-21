require 'rails_helper'

RSpec.describe 'Cart Show Page' do
  before :each do
    @megan = User.create!(name: 'MegansMarmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, user_name: "iamgmail.com", password: "test", role: 2)
    @brian = User.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218, user_name: "ian@gmail.com", password: "test", role: 2)
    @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
    @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
    @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
  end
  
  describe 'As a Visitor' do
    describe "When I have items in my cart, and I visit my cart" do
      it "I see information telling me I must register or log in to finish the checkout process" do
        visit item_path(@ogre)
        click_button 'Add to Cart'
        
        visit item_path(@giant)
        click_button 'Add to Cart'

        click_link "Cart"

        expect(page).to have_content("You must register or login to finish the checkout process")
        expect(page).to have_link("register")
        expect(page).to have_link("login")

        click_link "register"
        expect(current_path).to eq(register_path)

        click_link "Cart"

        click_link "login"
        expect(current_path).to eq(login_path)
      end
    end
  end
end
