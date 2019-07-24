require "rails_helper"

RSpec.describe "Navigation Restrictions", type: :feature do
  context "As a Visitor" do
    it "When I try to access any path that begins with '/merchant', I see a 404 error" do
      visit merchant_dashboard_path

      expect(page).to have_content("The page you were looking for doesn't exist.")
      expect(page.status_code).to eq(404)
    end

    it "When I try to access any path that begins with '/admin', I see a 404 error" do
      visit admin_dashboard_path

      expect(page).to have_content("The page you were looking for doesn't exist.")
      expect(page.status_code).to eq(404)
    end

    it "When I try to access any path that begins with '/profile', I see a 404 error" do
      visit profile_path

      expect(page).to have_content("The page you were looking for doesn't exist.")
      expect(page.status_code).to eq(404)
    end
  end

  context "As a Merchant" do
    before(:each) do
      @merchant = User.create!(name: "Sam", address: "1331 17th St.", city: "Denver", state: "CO", zip: 80202, user_name: "iam@gmail.com", password: "test", role: 2)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)
    end

    it "When I try to access any path that begins with '/cart', I see a 404 error" do
      visit "/cart"

      expect(page).to have_content("The page you were looking for doesn't exist.")
      expect(page.status_code).to eq(404)
    end

    it "When I try to access any path that begins with '/admin', I see a 404 error" do
      visit admin_dashboard_path

      expect(page).to have_content("The page you were looking for doesn't exist.")
      expect(page.status_code).to eq(404)
    end

    it "When I try to access any path that begins with '/profile', I see a 404 error" do
      visit profile_path

      expect(page).to have_content("The page you were looking for doesn't exist.")
      expect(page.status_code).to eq(404)
    end
  end

  context "As an Admin" do
    before(:each) do
      @admin = User.create!(name: "Sam", address: "1331 17th St.", city: "Denver", state: "CO", zip: 80202, user_name: "iam@gmail.com", password: "test", role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    end

    it "When I try to access any path that begins with '/cart', I see a 404 error" do
      visit "/cart"

      expect(page).to have_content("The page you were looking for doesn't exist.")
      expect(page.status_code).to eq(404)
    end

    it "When I try to access any path that begins with '/merchant', I see a 404 error" do
      visit merchant_dashboard_path

      expect(page).to have_content("The page you were looking for doesn't exist.")
      expect(page.status_code).to eq(404)
    end

    it "When I try to access any path that begins with '/profile', I see a 404 error" do
      visit profile_path

      expect(page).to have_content("The page you were looking for doesn't exist.")
      expect(page.status_code).to eq(404)
    end
  end

  context "As a (Registered) User" do
    before(:each) do
      @user = User.create!(name: "Sam", address: "1331 17th St.", city: "Denver", state: "CO", zip: 80202, user_name: "iam@gmail.com", password: "test", role: 0)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it "When I try to access any path that begins with '/merchant', I see a 404 error" do
      visit merchant_dashboard_path

      expect(page).to have_content("The page you were looking for doesn't exist.")
      expect(page.status_code).to eq(404)
    end

    it "When I try to access any path that begins with '/admin', I see a 404 error" do
      visit admin_dashboard_path

      expect(page).to have_content("The page you were looking for doesn't exist.")
      expect(page.status_code).to eq(404)
    end
  end
end
