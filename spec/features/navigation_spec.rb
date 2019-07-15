require 'rails_helper'

RSpec.describe 'Site Navigation' do
  describe 'As a Visitor' do
    it "I see a nav bar with links to all pages" do
      visit '/merchants'

      within 'nav' do
        click_link 'Items'
      end

      expect(current_path).to eq('/items')

      within 'nav' do
        click_link 'Merchants'
      end
      expect(current_path).to eq('/merchants')
    end

    it 'I see a cart indicator in my nav bar' do
      visit '/items'

      within 'nav' do
        expect(page).to have_content("Cart: 0")
        expect(page).to have_link('Cart: 0')
        click_link 'Cart: 0'
        expect(current_path).to eq(cart_path)
      end
    end

    it 'I see a link to return to the welcome / home page of the application' do
      visit '/merchants'

      within 'nav' do
        expect(page).to have_link('Home')
        click_link 'Home'
        expect(current_path).to eq(home_path)
      end
    end

    it 'I see a link to login' do
      visit '/'

      within 'nav' do
        expect(page).to have_link('Login')
      end
    end

    it 'I see a link to the user registration page' do
      visit '/'

      within 'nav' do
        expect(page).to have_link('Register')
        click_link 'Register'
        expect(current_path).to eq(register_path)
      end
    end
  end
end
