require 'rails_helper'

RSpec.describe "Modal form", :type => :request, js: true do
  # it "display modal on newspaper index page" do
  #   visit newspapers_path
  #   expect(page).to have_button("Create Newspaper")
  # end

  it "display validate if input title and content with nil" do

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

    visit newspapers_path
    click_button "Create Newspaper"

    within('#modal-content') do
      fill_in "title-newspaper", with: nil
      fill_in "content-newspaper", with: nil
      fill_in "newspaper_tag_list", with: nil
      click_button "Create"
    end

    expect(page).to have_content("2 errors prohibited this newspaper from being saved:")
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Content can't be blank")

    sleep 7
    expect(page).not_to have_content("2 errors prohibited this newspaper from being saved:")
    expect(page).not_to have_content("Title can't be blank")
    expect(page).not_to have_content("Content can't be blank")
  end

  it "display validate if input title and content with nil" do
    email = Faker::Internet.email
    password= '1234567'
    user = User.create(email: email, 
      password: password, 
      first_name: "Hoang",
      last_name: "Dinh")
      # first_name: Faker::Name.first_name, 
      # last_name:Faker::Name.last_name)

    visit "/"
    click_link "Sign In"

    fill_in "user_email", with: email
    fill_in "user_password", with: password
    click_button "Sign In"

    visit newspapers_path

    title = "NewYork"
    content = "Today is Friday"
    created_at = Time.now
    tag1 = Tag.create(name: "Book")
    tag2 = Tag.create(name: "Badminton")

    click_button "Create Newspaper"
    within('#modal-content') do
      fill_in "title-newspaper", with: "NewYork"
      fill_in "content-newspaper", with: "Today is Friday"
      fill_in "newspaper_tag_list", with: "Book, Badminton"

      click_button "Create"
    end
    sleep 7
    
    expect(page).to have_content("NewYork")
    expect(page).to have_content("Hoang Dinh")
    expect(page).to have_content("Today is Friday")
    expect(page).to have_content("Book, Badminton")
    expect(page).to have_content("Posted on less than a minute by Hoang Dinh")
    expect(page).to have_content("Newspaper already created successful")
    expect(page).to have_link("Read More")
    expect(page).to have_link("Edit")
    expect(page).to have_link("Destroy")
    expect(helper.risk_flag(2)).to eq("<i class=\"fa fa-tags btn btn-secondary tag-list\">  Tags</i>")
  end
end

