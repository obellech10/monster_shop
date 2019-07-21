require 'rails_helper'

RSpec.describe 'Merchant Index Page' do
  describe 'As a visitor' do
    before :each do
      @megan = User.create!(name: 'MegansMarmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, user_name: "iamgmail.com", password: "test", role: 2)
      @brian = User.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218, user_name: "ian@gmail.com", password: "test", role: 2)
    end

    it 'I see a list of all merchants' do
      visit '/merchants'

      within "#merchant-#{@megan.id}" do
        expect(page).to have_link(@megan.name)
      end

      within "#merchant-#{@brian.id}" do
        expect(page).to have_link(@brian.name)
      end
    end

    it 'I can click a link to get to a merchants show page' do
      visit '/merchants'

      click_link @megan.name

      expect(current_path).to eq("/merchants/#{@megan.id}")
    end
  end
end
