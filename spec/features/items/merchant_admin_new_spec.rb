require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe 'New Merchant Item' do
  before :each do
    @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)

    @merchant_admin = User.create!(name: "Diane", address: "1331 Main St.", city: "Denver", state: "CO", zip: 80202, user_name: "tom@gmail.com", password: "test", role: 2, merchant_id: @megan.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_admin)
  end

  describe 'As a merchant admin' do
    describe 'I see a link to add a new item' do
      it 'When I click the link I see a form where I can add info about a new item' do
        visit dashboard_items_path

        click_link 'New Item'

        expect(current_path).to eq(new_dashboard_item_path)

        name = 'Ogre'
        description = "I'm an Ogre!"
        price = 20
        default_image = "https://www.google.com/imgres?imgurl=http%3A%2F%2Fwww.stleos.uq.edu.au%2Fwp-content%2Fuploads%2F2016%2F08%2Fimage-placeholder-350x350.png&imgrefurl=http%3A%2F%2Fwww.stleos.uq.edu.au%2Flive-on-campus%2Faccommodation%2Fimage-placeholder%2F&docid=YPZY41tiqQXLcM&tbnid=8RNNVPLyHn5RyM%3A&vet=10ahUKEwiDt_GStszjAhVIU80KHS3HDHkQMwiKASgJMAk..i&w=350&h=350&bih=766&biw=1440&q=placeholder%20image&ved=0ahUKEwiDt_GStszjAhVIU80KHS3HDHkQMwiKASgJMAk&iact=mrc&uact=8"
        inventory = 5

        fill_in 'Name', with: name
        fill_in 'Description', with: description
        fill_in 'Price', with: price
        # fill_in 'Image', with: image -- absence of image for testing
        fill_in 'Inventory', with: inventory
        click_button 'Create Item'

        expect(current_path).to eq(dashboard_items_path)
        expect(page).to have_content("#{name} has been created")
        expect(page).to have_content(name)
        expect(page).to have_content("true")
        expect(page).to have_css("img[src*='#{default_image}']")
      end
    end

    it 'I cant create an item if details are left blank' do
      visit dashboard_items_path

      click_link 'New Item'

      expect(current_path).to eq(new_dashboard_item_path)

      name = 'Ogre'
      description = "I'm an Ogre!"

      fill_in 'Name', with: name
      fill_in 'Description', with: description
      click_button 'Create Item'

      expect(page).to have_content("Item details can't be left blank")
    end
  end
end
