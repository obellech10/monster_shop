require "rails_helper"

RSpec.describe "Merchant Dashboard Show Page", type: :feature do
  describe 'As a merchant' do
    before :each do
      @merchant = User.create!(name: "Sam", address: "1331 17th St.", city: "Denver", state: "CO", zip: 80202, user_name: "iam@gmail.com", password: "test", role: 2)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)
    end

    it 'I see all my profile details on the page and cannot edit them' do
      visit merchant_dashboard_path

      expect(current_path).to eq(merchant_dashboard_path)
      expect(page).to have_content("#{@merchant.name}'s Profile")
      expect(page).to have_content(@merchant.address)
      expect(page).to have_content(@merchant.city)
      expect(page).to have_content(@merchant.state)
      expect(page).to have_content(@merchant.zip)
      expect(page).to have_content(@merchant.user_name)
    end

    it "As a regular user i cannot visit the merchant dashboard path" do
      @user = User.create!(name: "Lisa", address: "1331 25th Ave.", city: "Miami", state: "FL", zip: 80242, user_name: "bird@gmail.com", password: "fish", role: 0)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit merchant_dashboard_path
      expect(page).to have_content("The page you were looking for doesn't exist (404)")
    end
  end
end
