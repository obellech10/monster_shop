require "rails_helper"

RSpec.describe "Admin Merchant Index Page", type: :feature do
  describe "As an admin user" do
    before(:each) do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)

      @merchant_admin = User.create!(name: "Sam", address: "1331 17th St.", city: "Denver", state: "CO", zip: 80202, user_name: "iam@gmail.com", password: "test", role: 2, merchant_id: @megan.id)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_admin)
    end

    describe "When I visit the merchant's index page at '/merchants'" do
      it "I see all merchants in the system" do
        visit merchants_path

        within "#merchant-#{@megan.id}" do
          expect(page).to have_content(@megan.name)
          expect(page).to have_link(@megan.name)
          expect(page).to have_content(@megan.city)
          expect(page).to have_content(@megan.state)
          expect(page).to have_button("Disable Merchant")
          expect(page).to_not have_button("Enable Merchant")
        end

        click_link(@megan.name)
        expect(current_path).to eq(admin_merchant_path(@megan))

        visit merchants_path

        within "#merchant-#{@brian.id}" do
          expect(page).to have_content(@brian.name)
          expect(page).to have_link(@brian.name)
          expect(page).to have_content(@brian.city)
          expect(page).to have_content(@brian.state)
          expect(page).to have_button("Disable Merchant")
          expect(page).to_not have_button("Enable Merchant")
        end

        click_link(@brian.name)
        expect(current_path).to eq(admin_merchant_path(@brian))
      end
    end
  end
end
