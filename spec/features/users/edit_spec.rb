require 'rails_helper'

RSpec.describe 'Edit User Profile' do
  describe 'As a registered User' do
    before(:each) do
      @user = User.create!(name: "Sam", address: "1331 17th St.", city: "Denver", state: "CO", zip: 80202, user_name: "iam@gmail.com", password: "test", role: 0)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'I can edit my profile' do
      visit profile_path

      expect(page).to have_link('Edit Profile')

      click_link 'Edit Profile'

      expect(current_path).to eq(edit_profile_path)

      fill_in "Name", with: "Tom"
      fill_in "Address", with: "123 Main St."
      fill_in "City", with: "New York"
      fill_in "State", with: "NY"

      click_button 'Update Profile'
      updated_profile = User.last

      expect(current_path).to eq(profile_path)
      expect(page).to have_content('User profile has been updated!')

      expect(page).to have_content(updated_profile.name)
      expect(page).to have_content(updated_profile.address)
      expect(page).to have_content(updated_profile.city)
      expect(page).to have_content(updated_profile.state)
      expect(page).to have_content(@user.zip)
      expect(page).to have_content(@user.user_name)
    end
  end
end
