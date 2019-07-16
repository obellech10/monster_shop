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

    it 'I see a flash message when I am missing required fields: name, city' do
      visit home_path

      click_link "Register"
      expect(current_path).to eq(register_path)

      # fill_in "Name", with: "Sam"
      fill_in "Address", with: "1331 17th St."
      # fill_in "City", with: "Denver"
      fill_in "State", with: "CO"
      fill_in "Zip", with: 80202
      fill_in "User Name", with: "iam@gmail.com"
      fill_in "Password", with: "test"
      fill_in "Confirm Password", with: "test"

      click_button "Create User"
      expect(page).to have_content("Name can't be blank and City can't be blank")
    end

    it 'I see a flash message when I do not have a unique email' do
      tom = User.create!(name: "Tom", address: "123 Main st", city: "Denver", state: "CO", zip: 80202, user_name: "iam@gmail.com", password: "test123" )

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

      expect(page).to have_content("User name has already been taken")
    end
  end
end
