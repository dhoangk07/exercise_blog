require 'rails_helper'

RSpec.describe "Modal form", :type => :request, js: true do
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
  end

  context "When input title and content with nil" do
    it "displays error messages" do
      click_button "create-newspaper"

      within('#modal-content') do
        fill_in "title-newspaper", with: nil
        fill_in "content-newspaper", with: nil
        fill_in "newspaper_tag_list", with: nil
        click_button "Create"
      end

      expect(page).to have_content("2 errors prohibited this newspaper from being saved:")
      expect(page).to have_content("Title can't be blank")
      expect(page).to have_content("Content can't be blank")

      expect(page).not_to have_content("2 errors prohibited this newspaper from being saved:")
      expect(page).not_to have_content("Title can't be blank")
      expect(page).not_to have_content("Content can't be blank")
    end
  end

  context "when input title and content not nil" do
    let(:title) { Faker::Lorem.sentence(2) }
    let(:content) { Faker::Lorem.words(10).join(" ") }

    before do
      tag1 = Tag.create(name: "Book")
      tag2 = Tag.create(name: "Badminton")
    end

    it "creates successfully" do
      
      click_button "create-newspaper"

      within('#modal-content') do
        fill_in "title-newspaper", with: title
        fill_in "content-newspaper", with: content
        fill_in "newspaper_tag_list", with: "Book, Badminton"

        click_button "Create"
      end
      expect(page).to have_content(title)
      expect(page).to have_content(content)
      expect(page).to have_content("Book, Badminton")
    end
  end
end

