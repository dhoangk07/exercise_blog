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
  it "generates a tag icon" do
    expect(helper.risk_flag(2)).to eq("<i class=\"fa fa-tags btn btn-secondary tag-list\">  Tags</i>")
    end
  end
end

