require 'rails_helper'

RSpec.describe "React Function", :type => :request, js: true do
  let(:email) { Faker::Internet.email }
  let(:password)  {'1234567'}
  let(:first_name)  { Faker::Name.first_name }
  let(:last_name)  { Faker::Name.last_name }
  let(:title) { Faker::Lorem.sentence(2)}
  let(:title_2) { Faker::Lorem.sentence(2)}
  let(:content)  {Faker::Lorem.words(10).join(" ")} 
  let(:user) { User.create(email: email, password: password, first_name: first_name, last_name: last_name) }
  let!(:newspaper) { Newspaper.create(title: title, content: content, user_id: user.id, published: true) }
  let(:newspaper_2) { Newspaper.create(title: title_2, content: content, user_id: user.id) }
  let(:reaction) {"like"}

  before do
    visit "/"
    click_link "Sign In"

    fill_in "user_email", with: email
    fill_in "user_password", with: password
    click_button "Sign In"

    visit newspapers_path
  end

  describe "reacted?" do

    it "should react with like reaction" do
      find(".like-btn").click 
      find(".like-btn-wrapper").click
      expect(page).to have_css("img.reaction-modal-js")
    end
  end
end


