require "rails_helper"

RSpec.describe "Admin enables a merchant account ", type: :feature do
  describe "As an admin merchant" do
    before(:each) do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, enabled: false)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218, enabled: false)

      @merchant_admin = User.create!(name: "Sam", address: "1331 17th St.", city: "Denver", state: "CO", zip: 80202, user_name: "iam@gmail.com", password: "test", role: "merchant_admin", merchant_id: @megan.id)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_admin)
    end

    describe "When I visit the merchant index page" do
      it "I see an 'enable' button next to any merchants whose accounts are disabled" do
        visit merchants_path

        within "#merchant-#{@megan.id}" do
          expect(page).to have_button("Enable Merchant")
        end

        visit merchants_path

        within "#merchant-#{@brian.id}" do
          expect(page).to have_button("Enable Merchant")
        end
      end

      describe "When I click on the 'enable' button" do
        it "I am returned to the admin's merchant index page where I see that the merchant's account is now enabled and see a flash message that the merchant's account is now enabled" do
          visit merchants_path
          expect(@megan.enabled).to eq(false)

          within "#merchant-#{@megan.id}" do
            click_button("Enable Merchant")
          end

          expect(current_path).to eq(admin_merchants_path)
          expect(page).to have_content("#{@megan.name}'s account is now enabled.")
          expect(@megan.reload.enabled).to eq(true)

          within "#merchant-#{@megan.id}" do
            expect(page).to have_content(@megan.address)
            expect(page).to have_content(@megan.city)
            expect(page).to have_content(@megan.state)
            expect(page).to have_content(@megan.zip)
            expect(page).to have_content(@megan.created_at.to_date)
            expect(page).to have_content("Enabled: true")
          end

          visit merchants_path
          expect(@brian.enabled).to eq(false)

          within "#merchant-#{@brian.id}" do
            click_button("Enable Merchant")
          end

          expect(current_path).to eq(admin_merchants_path)
          expect(page).to have_content("#{@brian.name}'s account is now enabled.")
          expect(@brian.reload.enabled).to eq(true)

          within "#merchant-#{@brian.id}" do
            expect(page).to have_content(@brian.address)
            expect(page).to have_content(@brian.city)
            expect(page).to have_content(@brian.state)
            expect(page).to have_content(@brian.zip)
            expect(page).to have_content(@brian.created_at.to_date)
            expect(page).to have_content("Enabled: true")
          end
        end
      end
    end
  end
end
