require 'rails_helper'

RSpec.describe "home page", :type => :request do
  it "displays the home page" do
    visit "/"

    expect(page).to have_content("Sign In")
    expect(page).to have_content("Sign Up")
    expect(page).to have_link("Learn more")
  end
end