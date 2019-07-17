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
  describe "As a Registered User" do
    it "I see the same links as a visitor plus a link to my profile and to logout" do
      user = User.create!(name: "Sam", address: "1331 17th St.", city: "Denver", state: "CO", zip: 80202, user_name: "iam@gmail.com", password: "test", role: 0)
      visit login_path

      fill_in "User Name", with: "iam@gmail.com"
      fill_in "Password", with: "test"

      click_button "Login"
      visit '/'

      within 'nav' do
        expect(page).to have_link('Logout')
        expect(page).to have_link('Profile')
        expect(page).to_not have_link('Login')
        expect(page).to_not have_link('Register')
        expect(page).to have_content("Logged in as #{user.name}.")
      end
    end
  end
  describe "As a user who works for a merchant" do
    it "I see the same links as a visitor plus a link to my merchant dashboard and to logout" do
      user = User.create!(name: "Sam", address: "1331 17th St.", city: "Denver", state: "CO", zip: 80202, user_name: "iam@gmail.com", password: "test", role: 2)
      visit login_path

      fill_in "User Name", with: "iam@gmail.com"
      fill_in "Password", with: "test"

      click_button "Login"
      visit '/'

      within 'nav' do
        expect(page).to have_link('Logout')
        expect(page).to have_link('Dashboard')
        expect(page).to_not have_link('Login')
        expect(page).to_not have_link('Register')
        expect(page).to have_content("Logged in as #{user.name}.")
      end
    end
  end
end
