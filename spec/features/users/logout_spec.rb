require "rails_helper"

RSpec.describe "User can Logout", type: :feature do
  it 'As a Registered User when I logout my cart is emptied' do
    megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
    ogre = megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
    user = User.create!(name: "Sam", address: "1331 17th St.", city: "Denver", state: "CO", zip: 80202, user_name: "iam@gmail.com", password: "test", role: 0)

    visit login_path

    fill_in "User Name", with: "iam@gmail.com"
    fill_in "Password", with: "test"

    click_button "Login"

    visit item_path(ogre)

    click_button 'Add to Cart'
    expect(page).to have_content("Cart: 1")

    click_link 'Logout'

    expect(current_path).to eq(home_path)
    expect(page).to have_content("Cart: 0")
    expect(page).to have_content("#{user.name} is now logged out!")
  end


  describe 'Merchant Admin can log out' do
    it 'As a Merchant Admin when I logout my cart is emptied' do
      megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      ogre = megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      merchant = User.create!(name: "Sam", address: "1331 17th St.", city: "Denver", state: "CO", zip: 80202, user_name: "iam@gmail.com", password: "test", role: 2)

      visit login_path

      fill_in "User Name", with: "iam@gmail.com"
      fill_in "Password", with: "test"

      click_button "Login"

      visit item_path(ogre)

      click_button 'Add to Cart'
      expect(page).to have_content("Cart: 1")

      click_link 'Logout'

      expect(current_path).to eq(home_path)
      expect(page).to have_content("Cart: 0")
      expect(page).to have_content("#{merchant.name} is now logged out!")
    end
  end

  describe 'Admin can log out' do
    it 'As a Admin when I logout I return to the welcome page' do
      admin = User.create!(name: "Sam", address: "1331 17th St.", city: "Denver", state: "CO", zip: 80202, user_name: "iam@gmail.com", password: "test", role: 1)

      visit login_path

      fill_in "User Name", with: "iam@gmail.com"
      fill_in "Password", with: "test"

      click_button "Login"

      click_link 'Logout'

      expect(current_path).to eq(home_path)
      expect(page).to have_content("#{admin.name} is now logged out!")
    end
  end
end
