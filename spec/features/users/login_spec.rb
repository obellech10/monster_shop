require "rails_helper"

RSpec.describe "User can Login", type: :feature do
  describe "As a visitor, when I visit the login path" do
    context "I see a field to enter my email address and password" do
      it "If I am a Regular User, I am redirected to my profile page" do
        user = User.create!(name: "Sam", address: "1331 17th St.", city: "Denver", state: "CO", zip: 80202, user_name: "iam@gmail.com", password: "test", role: 0)

        visit login_path

        fill_in "User Name", with: "iam@gmail.com"
        fill_in "Password", with: "test"

        click_button "Login"

        expect(current_path).to eq(profile_path)
        expect(page).to have_content("#{user.name} is logged in.")
      end

      it "If I am a Merchant User, I am redirected to my merchant dashboard page" do
        merchant = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
        merchant_admin = User.create!(name: "Sam", address: "1331 17th St.", city: "Denver", state: "CO", zip: 80202, user_name: "iam@gmail.com", password: "test", role: 2, merchant_id: merchant.id)

        visit login_path

        fill_in "User Name", with: "iam@gmail.com"
        fill_in "Password", with: "test"

        click_button "Login"

        expect(current_path).to eq("/merchant")
        expect(page).to have_content("#{merchant_admin.name} is logged in.")
      end

      it "If I am a Admin User, I am redirected to my admin dashboard page" do
        admin = User.create!(name: "Sam", address: "1331 17th St.", city: "Denver", state: "CO", zip: 80202, user_name: "iam@gmail.com", password: "test", role: 1)

        visit login_path

        fill_in "User Name", with: "iam@gmail.com"
        fill_in "Password", with: "test"

        click_button "Login"

        expect(current_path).to eq("/admin")
        expect(page).to have_content("#{admin.name} is logged in.")
      end
    end

    context "When I visit the login page and submit invalid information" do
      it "I am redirected to the login page and see a flash message that tells me that my credentials were incorrect" do
        user = User.create!(name: "Sam", address: "1331 17th St.", city: "Denver", state: "CO", zip: 80202, user_name: "iam@gmail.com", password: "test")

        visit login_path

        fill_in "User Name", with: "iam@gmail.com"
        fill_in "Password", with: "fail"

        click_button "Login"

        expect(current_path).to eq(login_path)
        expect(page).to have_content("Incorrect user name or password")
      end
    end

    describe "Users who are logged in already are redirected" do
      context "As a Registered User" do
        it "When I visit the login path, I am redirected to my profile page, and see a flash message that I am logged in" do
          user = User.create!(name: "Sam", address: "1331 17th St.", city: "Denver", state: "CO", zip: 80202, user_name: "iam@gmail.com", password: "test", role: 0)

          allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

          visit login_path

          expect(current_path).to eq(profile_path)
          expect(page).to have_content("#{user.name} is logged in.")
        end
      end

      context "As a Merchant" do
        it "When I visit the login path, I am redirected to my merchant dashboard page, and see a flash message that I am logged in" do
          merchant = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
          merchant_admin = User.create!(name: "Sam", address: "1331 17th St.", city: "Denver", state: "CO", zip: 80202, user_name: "iam@gmail.com", password: "test", role: 2, merchant_id: merchant.id)

          allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_admin)

          visit login_path

          expect(current_path).to eq(merchant_dashboard_path)
          expect(page).to have_content("#{merchant_admin.name} is logged in.")
        end
      end

      context "As an Admin" do
        it "When I visit the login path, I am redirected to my admin dashboard page, and see a flash message that I am logged in" do
          admin = User.create!(name: "Sam", address: "1331 17th St.", city: "Denver", state: "CO", zip: 80202, user_name: "iam@gmail.com", password: "test", role: 1)

          allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

          visit login_path

          expect(current_path).to eq(admin_dashboard_path)
          expect(page).to have_content("#{admin.name} is logged in.")
        end
      end
    end
  end
end
