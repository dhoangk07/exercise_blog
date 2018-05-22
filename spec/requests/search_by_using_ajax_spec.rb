require 'rails_helper'

RSpec.describe "Search form", :type => :request, js: true do
  before do
    email = Faker::Internet.email
          password= '1234567'
          @user = User.create(email: email, 
            password: password, 
            first_name: Faker::Name.first_name, 
            last_name:Faker::Name.last_name)

          visit "/"
          click_link "Sign In"

          fill_in "user_email", with: email
          fill_in "user_password", with: password
          click_button "Sign In"

          visit newspapers_path

  user_1 = User.create!(first_name: "Hoang", last_name: "Dinh", email: "dhoanghvs@gmail.com", password: "1234567")

  user_2 = User.create!(first_name: "Huy", last_name: "Dinh", email: "dhuy@gmail.com", password: "1234567")

  vietnam = Newspaper.create!(title: "VietNam", content: "Lorem", user_id: user_1.id, role: "user")
  laos = Newspaper.create!(title: "Laos", content: "Lorem1", user_id: user_2.id, role: "user")
  end

  context "When input title and content with nil" do
    it "displays page with title and content nil" do
      
      fill_in "search", with: nil
      click_button "Go!"
      
      expect(page).not_to have_content("Thailand")
      expect(page).not_to have_content("sdvdcsdsd")
    end
  end

  context "When input title and content with not nil" do
    it "displays page with title and content" do
      
      fill_in "search", with: "VietNam"
      click_button "Go!"

      
      expect(page).to have_content("VietNam")
      expect(page).not_to have_content("Laos")
    end
  end
end

