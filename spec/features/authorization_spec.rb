require "rails_helper"

RSpec.describe "Navigation Restrictions", type: :feature do
  context "As a Visitor" do
    it "When I try to access any path that begins with '/merchant', I see a 404 error" do
      visit "/merchant"

      expect(page).to have_content("The page you were looking for doesn't exist.")
      expect(page.status_code).to eq(404)
    end

    it "When I try to access any path that begins with '/admin', I see a 404 error" do
      visit "/admin"

      expect(page).to have_content("The page you were looking for doesn't exist.")
      expect(page.status_code).to eq(404)
    end

    it "When I try to access any path that begins with '/profile', I see a 404 error" do
      visit profile_path

      expect(page).to have_content("The page you were looking for doesn't exist.")
      expect(page.status_code).to eq(404)
    end
  end
end
