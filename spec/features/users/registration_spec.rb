require "rails_helper"

RSpec.describe "User Registration", type: :feature do
  describe "As a visitor" do
    it "can register a new user" do
      visit home_path

      click_link "Register"
      expect(current_path).to eq(register_path)

      fill_in "Name", with: "Sam"
      fill_in "Address", with: "1331 17th St."
      fill_in "City", with: "Denver"
      fill_in "State", with: "CO"
      fill_in "Zip", with: 80202
      fill_in "User Name", with: "iam@gmail.com"
      fill_in "Password", with: "test"
      fill_in "Confirm Password", with: "test"

      click_button "Create User"

      new_user = User.last

      expect(current_path).to eq("/profile")
      expect(page).to have_content("#{new_user.name} is now registered and logged in!")
    end
  end
end
