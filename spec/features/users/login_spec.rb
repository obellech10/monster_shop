require "rails_helper"

RSpec.describe "User can Login", type: :feature do
  describe "As a visitor, when I visit the login path" do
    context "I see a field to enter my email address and password" do
      it "If I am a Regular User, I am redirected to my profile page" do
        user = User.create!(name: "Sam", address: "1331 17th St.", city: "Denver", state: "CO", zip: 80202, user_name: "iam@gmail.com", password: "test")

        visit login_path

        fill_in "User Name", with: "iam@gmail.com"
        fill_in "Password", with: "test"

        click_button "Login"

        expect(current_path).to eq(profile_path)
        expect(page).to have_content("#{user.name} is logged in.")
      end
    end
  end
end
