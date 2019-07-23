require "rails_helper"

RSpec.describe "Admin disables a merchant account", type: :feature do
  describe "As an admin" do
    before(:each) do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, enabled: true)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218, enabled: true)

      @admin = User.create!(name: "Sam", address: "1331 17th St.", city: "Denver", state: "CO", zip: 80202, user_name: "iam@gmail.com", password: "test", role: "admin")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    end

    describe "When I visit the merchant index page" do
      it "I see a 'disable' button next to any merchants who are not yet disabled" do
        visit merchants_path

        within "#merchant-#{@megan.id}" do
          expect(page).to have_button("Disable Merchant")
        end

        visit merchants_path

        within "#merchant-#{@brian.id}" do
          expect(page).to have_button("Disable Merchant")
        end
      end

      describe "When I click on the 'disable' button" do
        it "I am returned to the admin's merchant index page where I see that the merchant's account is now disabled and see a flash message that the merchant's account is now disabled" do
          visit merchants_path
          expect(@megan.enabled).to eq(true)

          within "#merchant-#{@megan.id}" do
            click_button("Disable Merchant")
          end

          expect(current_path).to eq(admin_merchants_path)
          expect(page).to have_content("#{@megan.name}'s account is now disabled.")
          expect(@megan.reload.enabled).to eq(false)

          within "#merchant-#{@megan.id}" do
            expect(page).to have_content(@megan.address)
            expect(page).to have_content(@megan.city)
            expect(page).to have_content(@megan.state)
            expect(page).to have_content(@megan.zip)
            expect(page).to have_content(@megan.created_at.to_date)
            expect(page).to have_content("Enabled: false")
          end

          visit merchants_path
          expect(@brian.enabled).to eq(true)

          within "#merchant-#{@brian.id}" do
            click_button("Disable Merchant")
          end

          expect(current_path).to eq(admin_merchants_path)
          expect(page).to have_content("#{@brian.name}'s account is now disabled.")
          expect(@brian.reload.enabled).to eq(false)

          within "#merchant-#{@brian.id}" do
            expect(page).to have_content(@brian.address)
            expect(page).to have_content(@brian.city)
            expect(page).to have_content(@brian.state)
            expect(page).to have_content(@brian.zip)
            expect(page).to have_content(@brian.created_at.to_date)
            expect(page).to have_content("Enabled: false")
          end
        end
      end
    end
  end
end
