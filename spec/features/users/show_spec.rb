require "rails_helper"

RSpec.describe "User Profile Show Page", type: :feature do
  describe 'As a registered user' do
    it 'I see all my profile details on the page except password' do

      # allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      # visit profile_path

      user = User.create!(name: "Sam", address: "1331 17th St.", city: "Denver", state: "CO", zip: 80202, user_name: "iam@gmail.com", password: "test", role: 0)

      visit login_path

      fill_in "User Name", with: "iam@gmail.com"
      fill_in "Password", with: "test"

      click_button "Login"

      expect(page).to have_content("#{user.name}'s Profile")
      expect(page).to have_content(user.address)
      expect(page).to have_content(user.city)
      expect(page).to have_content(user.state)
      expect(page).to have_content(user.zip)
      expect(page).to have_content(user.user_name)
      expect(page).to have_link("Edit Profile")
    end
  end
end
