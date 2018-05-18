require 'rails_helper'

RSpec.describe "Without SignIn", :type => :request do
  it "visit homepage" do
    visit "/"
    expect(page).to have_content("Newspapers")
    expect(page).to have_content("Home")
    expect(page).to have_content("Sign In")
    expect(page).to have_content("Sign Up")
    expect(page).to have_link("Learn more")
    expect(page).to have_content("Jumbotron")
    expect(page).to have_content("This is a full-screen centered hero unit.")
  end

  it "visit newspaper index page" do
    visit newspapers_path
    expect(page).to have_content("Search")
    expect(page).to have_content("Categories")
    expect(page).to have_content("Side Widget")
    expect(page).to have_content("Copyright © Your Website 2018")
  end
end

