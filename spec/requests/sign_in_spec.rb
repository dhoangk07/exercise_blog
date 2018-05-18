require 'rails_helper'

RSpec.describe "sign in page", :type => :request, js: true do
  it "displays the sign in page" do
    email = Faker::Internet.email
    password= '1234567'
    user = User.create(email: email, 
      password: password, 
      first_name: "Hoang",
      last_name: "Dinh")

    visit "/"
    click_link "Sign In"
    fill_in "user_email", with: email
    fill_in "user_password", with: password
    click_button "Sign In"

    expect(page).to have_content("Signed in successfully.")
    expect(page).to have_content("Log Out")
    expect(page).not_to have_content("Hoang Dinh")
    expect(page).not_to have_content("Sign In")
    expect(page).not_to have_content("Admin")
  end
end