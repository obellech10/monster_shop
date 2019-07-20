require "rails_helper"

RSpec.describe "Admin User Index", type: :feature do
  describe 'As an admin user' do
    before :each do
      @user_1 = User.create!(name: "Diane", address: "1331 Main St.", city: "Denver", state: "CO", zip: 80202, user_name: "tom@gmail.com", password: "test", role: 0)
      @user_2 = User.create!(name: "Sam", address: "1331 Main St.", city: "Denver", state: "IA", zip: 80202, user_name: "sam@gmail.com", password: "test", role: 0)
    end

    it "When I click the 'users' link in the nav I see all users in the system" do
      admin = User.create!(name: "Jack", address: "1331 Main St.", city: "Denver", state: "CO", zip: 80202, user_name: "jack@gmail.com", password: "test", role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit home_path

      click_link 'Users'
      expect(current_path).to eq(admin_users_path)

      within "#user-#{@user_1.id}" do
        expect(page).to have_content(@user_1.name)
        expect(page).to have_link(@user_1.name)
        expect(page).to have_content(@user_1.created_at)
        expect(page).to have_content(@user_1.role)
      end

      within "#user-#{@user_2.id}" do
        expect(page).to have_content(@user_2.name)
        expect(page).to have_link(@user_2.name)
        expect(page).to have_content(@user_2.created_at)
        expect(page).to have_content(@user_2.role)
      end
    end

    it "the 'Users' link in the nav is only visible to admins" do
      user = User.create!(name: "Jack", address: "1331 Main St.", city: "Denver", state: "CO", zip: 80202, user_name: "jack@gmail.com", password: "test", role: 0)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit home_path

      expect(page).to_not have_link('Users')
    end
  end

  describe 'As a merchant admin' do
    it "the 'Users' link does NOT appear in the nav" do
      merchant_admin = User.create!(name: "Jack", address: "1331 Main St.", city: "Denver", state: "CO", zip: 80202, user_name: "jack@gmail.com", password: "test", role: 2)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_admin)

      visit home_path

      expect(page).to_not have_link('Users')
    end
  end
end
