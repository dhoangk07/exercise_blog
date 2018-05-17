require 'rails_helper'

RSpec.describe "Categories form", :type => :request, js: true do
  it "display categories on newspaper index page" do
    visit newspapers_path
    
    expect(page).to have_content("Categories")
  end

  it "display categories after newspaper have tag" do

    email = Faker::Internet.email
    password= '1234567'
    user = User.create(email: email, 
      password: password, 
      first_name: Faker::Name.first_name, 
      last_name:Faker::Name.last_name)

    visit "/"
    click_link "Sign In"

    fill_in "user_email", with: email
    fill_in "user_password", with: password
    click_button "Sign In"

    sleep 7

    visit new_newspaper_path

    title = Faker::Lorem.sentence(2)
    content = Faker::Lorem.sentence(30)
    image = Faker::Avatar.image
    tag = Tag.create(name: "Sport")

    title = "NewYork"
    content = "Today is Thursday"
    tag = Tag.create(name: "Sport")

    # newspaper = Newspaper.create(title: title, conten: content)

    # user_1 = User.create!(first_name: "Hoang", last_name: "Dinh", email: "dhoanghvs@gmail.com", password: "1234567")
    # user_2 = User.create!(first_name: "Huy", last_name: "Dinh", email: "dhuy@gmail.com", password: "1234567")

    # vietnam = Newspaper.create!(title: "VietNam", content: "Lorem", user_id: user_1.id, role: "user")
    # laos = Newspaper.create!(title: "Laos", content: "Lorem1", user_id: user_2.id, role: "user")

    # tag_1 = Tag.create!(name: "Sport")

    fill_in "newspaper_title", with: title
    fill_in "newspaper_content", with: content
    fill_in "newspaper_tag_list", with: tag
    page.attach_file('newspaper[image]', Rails.root + 'spec/Fixtures/user.jpg')
    
    click_button "Create Newspaper"

    sleep 5
    visit newspapers_path

    expect(page).to have_content("NewYork")

    expect(page).to have_content("Today is Thursday")

    expect(page).to have_content("Sport")

  end
end

